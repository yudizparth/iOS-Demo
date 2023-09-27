//
//  NetflixVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 26/09/23.
//

import UIKit
import AVFoundation

class NetflixVC: UIViewController {
    
    var player : AVPlayer? = nil
    var playerLayer : AVPlayerLayer? = nil
    var timeObserver : Any? = nil
    var isThumbSeek : Bool = false
    let videoURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    var hideTimer: Timer?
    
    
    
    @IBOutlet weak var videoPlayer: UIView!
    @IBOutlet weak var videoPlayerHeight: NSLayoutConstraint!
    @IBOutlet weak var viewControll: UIView! {
        didSet{
            viewControll.isUserInteractionEnabled = true
            self.viewControll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapToStartTimer)))
            
        }
    }
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var stackCtrView: UIStackView!
    @IBOutlet weak var img10SecBack: UIImageView! {
        didSet {
            self.img10SecBack.isUserInteractionEnabled = true
            self.img10SecBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap10SecBack)))
        }
    }
    @IBOutlet weak var imgPlay: UIImageView! {
        didSet {
            self.imgPlay.isUserInteractionEnabled = true
            self.imgPlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPlayPause)))
        }
    }
    @IBOutlet weak var img10SecFor: UIImageView! {
        didSet {
            self.img10SecFor.isUserInteractionEnabled = true
            self.img10SecFor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap10SecNext)))
        }
    }
    @IBOutlet weak var lbCurrentTime: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var seekSlider: UISlider! {
        didSet {
            self.seekSlider.addTarget(self, action: #selector(onTapToSlide), for: .valueChanged)
        }
    }
    @IBOutlet weak var imgFullScreenToggle: UIImageView! {
        didSet {
            self.imgFullScreenToggle.isUserInteractionEnabled = true
            self.imgFullScreenToggle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapToggleScreen)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        player?.pause()
        player = nil
        playerLayer  = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setVideoPlayer()
    }
    
    func setVideoPlayer() {
        guard let url = URL(string: videoURL) else { return }
        if self.player == nil {
            self.player = AVPlayer(url: url)
            self.playerLayer = AVPlayerLayer(player: player)
            self.playerLayer?.videoGravity = .resizeAspectFill
            self.playerLayer?.frame = self.videoPlayer.bounds
            self.playerLayer?.addSublayer(self.viewControll.layer)
            if let playerLayer = self.playerLayer {
                self.view.layer.addSublayer(playerLayer)
            }
            self.player?.play()
            self.imgPlay.image = UIImage(systemName: "pause.circle")
        }
        self.setObserverToPlayer()
    }
    
    var windowInterface : UIInterfaceOrientation? {
        return self.view.window?.windowScene?.interfaceOrientation
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        guard let windowInterface = self.windowInterface else { return }
        if windowInterface.isPortrait ==  true {
            self.videoPlayerHeight.constant = 300
        } else {
            self.videoPlayerHeight.constant = self.view.layer.bounds.width
        }
        print(self.videoPlayerHeight.constant)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.playerLayer?.frame = self.videoPlayer.bounds
        })
    }
}


extension NetflixVC {
    @IBAction func tapToBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - Functions
extension NetflixVC {
    
    @objc func onTap10SecNext(_ sender: UIGestureRecognizer) {
        guard let currentTime = player?.currentTime() else { return }
        let seekTime10Sec = CMTimeGetSeconds(currentTime).advanced(by: 10)
        let seekTime = CMTime(value: CMTimeValue(seekTime10Sec), timescale: 1)
        self.player?.seek(to: seekTime, completionHandler: { completed in})
    }
    
    @objc func onTap10SecBack(_ sender: UIGestureRecognizer) {
        guard let currentTime = player?.currentTime() else { return }
        let seekTime10Sec = CMTimeGetSeconds(currentTime).advanced(by: -10)
        let seekTime = CMTime(value: CMTimeValue(seekTime10Sec), timescale: 1)
        player?.seek(to: seekTime, completionHandler: { completed in})
    }
    
    @objc func onTapPlayPause(_ sender: UIGestureRecognizer) {
        if player?.timeControlStatus == .playing {
            imgPlay.image = UIImage(systemName: "play.circle")
            player?.pause()
        } else {
            imgPlay.image = UIImage(systemName: "pause.circle")
            player?.play()
        }
       
        switch sender.state {
        case .began:
            print("began")
            invalideTimer()
        case .ended:
            onTapToStartTimer()
            print("ended")
        default:
            break
        }
    }
    
    @objc func onTapToSlide(_ sender: UIGestureRecognizer) {
        self.isThumbSeek = true
        guard let duration = self.player?.currentItem?.duration else { return }
        let value = Float64(self.seekSlider.value) * CMTimeGetSeconds(duration)
        if value.isNaN == false {
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            self.player?.seek(to: seekTime, completionHandler: { completed in
                if completed {
                    self.isThumbSeek = false
                }
            })
        }
        
    }
    
    func invalideTimer(){
        hideTimer?.invalidate()
        hideTimer = nil
    }
    
    @objc  func onTapToggleScreen() {
        if #available(iOS 16.0, *) {
            guard let windowSceen = self.view.window?.windowScene else { return }
            if windowSceen.interfaceOrientation == .portrait {
                windowSceen.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape)) { error in
                    print(error.localizedDescription)
                }
            } else {
                windowSceen.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait)) { error in
                    print(error.localizedDescription)
                }
            }
        } else {
            if UIDevice.current.orientation == .portrait {
                let orientation = UIInterfaceOrientation.landscapeRight.rawValue
                UIDevice.current.setValue(orientation, forKey: "orientation")
            } else {
                let orientation = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(orientation, forKey: "orientation")
            }
        }
    }
    
    
    @objc func onTapToStartTimer() {
        hideTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(hideView), userInfo: nil, repeats: false)
    }
    
    @objc func hideView() {
        if hideTimer != nil {
            stackCtrView.alpha = 1.0
            lbCurrentTime.alpha = 1.0
            lbTotalTime.alpha = 1.0
            seekSlider.alpha = 1.0
            imgFullScreenToggle.alpha = 1.0
            btnBack.alpha = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                UIView.animate(withDuration: 2.0) {
                    self.stackCtrView.alpha = 0.0
                    self.lbCurrentTime.alpha = 0.0
                    self.lbTotalTime.alpha = 0.0
                    self.seekSlider.alpha = 0.0
                    self.imgFullScreenToggle.alpha = 0.0
                    self.btnBack.alpha = 0.0
                    print("View call ")
                }
            }
        }
    }
}

//MARK: - Methods
extension NetflixVC {
    
    func setObserverToPlayer() {
        let interval = CMTime(seconds: 0.3, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsed in
            self.updatePlayerTime()
        })
        onTapToStartTimer()
        
    }
    
    func updatePlayerTime() {
        guard let currentTime = player?.currentTime() else { return }
        guard let duration = player?.currentItem?.duration else { return }
        
        let currentTimeInSecond = CMTimeGetSeconds(currentTime)
        let durationTimeInSecond = CMTimeGetSeconds(duration)
        
        if self.isThumbSeek == false {
            self.seekSlider.value = Float(currentTimeInSecond/durationTimeInSecond)
        }
        
        let value = Float64(self.seekSlider.value) * CMTimeGetSeconds(duration)
        
        var hours = value / 3600
        var mins =  (value / 60).truncatingRemainder(dividingBy: 60)
        var secs = value.truncatingRemainder(dividingBy: 60)
        var timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let hoursStr = timeformatter.string(from: NSNumber(value: hours)), let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
            return
        }
        self.lbCurrentTime.text = "\(hoursStr):\(minsStr):\(secsStr)"
        
        hours = durationTimeInSecond / 3600
        mins = (durationTimeInSecond / 60).truncatingRemainder(dividingBy: 60)
        secs = durationTimeInSecond.truncatingRemainder(dividingBy: 60)
        timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let hoursStr = timeformatter.string(from: NSNumber(value: hours)), let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
            return
        }
        self.lbTotalTime.text = "\(hoursStr):\(minsStr):\(secsStr)"
    }
    
    
}
