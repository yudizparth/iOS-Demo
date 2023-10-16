//
//  CustomCameraVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 10/10/23.
//

import UIKit
import Photos

import AVFoundation

class CustomCameraVC: UIViewController, AVCapturePhotoCaptureDelegate , AVCaptureFileOutputRecordingDelegate {
    
    @IBOutlet weak var imgChangCamera: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgPreviewImage : UIImageView!{
        didSet {
            imgPreviewImage.layer.cornerRadius = imgPreviewImage.frame.size.width / 2
            imgPreviewImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var imgTapToCapture: UIImageView!
    
    var isVideo : Bool = false
    var isVideoRecording : Bool = false
    //Capture Session
    var session : AVCaptureSession?
    //Capture Image
    var imageOutput = AVCapturePhotoOutput()
    //Video Pre-View
    var previewLayer = AVCaptureVideoPreviewLayer()
    var movieOutput = AVCaptureMovieFileOutput()
    var audioInput :  AVCaptureDeviceInput?
    var currentCamera: AVCaptureDevice.Position = .back
    // Initially set to the back camera
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        checkCameraPermission()
    }
    
}

extension CustomCameraVC {
    @IBAction func tapToChangeCamera(_ sender : UIButton){
        if session?.isRunning == true {
            session?.removeOutput(isVideo == false ? imageOutput : movieOutput)
            session?.stopRunning()
        }
        if currentCamera == .back {
            currentCamera = .front
            setupCamera()
        } else {
            currentCamera = .back
            setupCamera()
        }
    }
    
}


extension CustomCameraVC {
    
    func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined :
            setupCamera()
            break
        case .denied :
            openSettingsActionSheet()
            break
        case .restricted :
            openSettingsActionSheet()
            break
        case .authorized :
            setupCamera()
            break
        default :
            break
        }
    }
    
    func setupCamera(){
        AVCaptureDevice.requestAccess(for: .video) { granted in
            guard granted else {return}
        }
        let session = AVCaptureSession()
        if let newCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: currentCamera).devices.first {
            do {
                let input = try AVCaptureDeviceInput(device: newCamera)
                if isVideo == true{
                    let microPhone = AVCaptureDevice.default(for: .audio)!
                    do {
                        let micInpout = try AVCaptureDeviceInput(device: microPhone)
                        session.addInput(micInpout)
                    }catch {
                        print("Error Hai Bhai \(error)")
                    }
                }
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if isVideo == true{
                    if session.canAddOutput(movieOutput) {
                        session.addOutput(movieOutput)
                    }
                }else {
                    if session.canAddOutput(imageOutput) {
                        session.addOutput(imageOutput)
                    }
                }
                session.startRunning()
                self.session = session
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                previewLayer.frame = cameraView.bounds
                cameraView.layer.addSublayer(previewLayer)
            } catch {
                print("error")
            }
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        saveVideoToPhotoLibrary(outputFileURL)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let timestamp = dateFormatter.string(from: Date())
        let filename = "image_\(timestamp).jpg"
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(filename)
            do {
                try data.write(to: fileURL)
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: UIImage(data: data)!)
                }, completionHandler: { (success, error) in
                    if success {
                        print("Image saved to Photos Library")
                        DispatchQueue.main.async {
                            self.imgPreviewImage.image = UIImage(data: data)
                        }
                    } else if let error = error {
                        print("Error saving image to Photos Library: \(error)")
                    }
                })
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    
    func prepareUI(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapToTakePhoto))
        let toggelCameraVideo = UITapGestureRecognizer(target: self, action: #selector(tapToChange))
        imgTapToCapture.isUserInteractionEnabled = true
        imgChangCamera.isUserInteractionEnabled = true
        imgChangCamera.addGestureRecognizer(toggelCameraVideo)
        imgTapToCapture.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapToTakePhoto(){
        if isVideo == false{
            if imageOutput.connection(with: .video) != nil {
                imageOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            }
        }else {
            imgTapToCapture.image = UIImage(named:  isVideoRecording == false ? "ic_recording" :  "ic_shutter")
            isVideoRecording  == false ?  startRecordingVideo()  :   stopRecordingVideo()
        }
    }
    
    @objc func tapToChange(){
        imgChangCamera.tintColor = .white
        imgChangCamera.image = UIImage(systemName:  isVideo ? "camera.metering.partial" :  "video.fill")
        if isVideo == true {
            imgTapToCapture.image = UIImage(named: "ic_shutter")
        }
        isVideo.toggle()
        setupCamera()
    }
    
    func startRecordingVideo() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let videoFileName = "video.mov"
        let fileURL = documentsDirectory?.appendingPathComponent(videoFileName)
        movieOutput.startRecording(to: fileURL!, recordingDelegate: self)
        isVideoRecording = true
    }
    
    func stopRecordingVideo() {
        isVideoRecording = false
        movieOutput.stopRecording()
    }
    
    func saveVideoToPhotoLibrary(_ videoURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }) { success, error in
            if success {
                print("Video saved to Photos Library")
            } else if let error = error {
                print("Error saving video to Photos Library: \(error)")
            }
        }
    }
    
    
    @objc func tapToBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func openSettingsActionSheet() {
        let alertController = UIAlertController(title: "App Permissions", message: "To enable all features, please open Settings and grant the necessary permissions.", preferredStyle: .actionSheet)
        let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            PermissionHelper.shared.openSettings()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)
    }
}
