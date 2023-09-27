//
//  VideoVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 25/09/23.
//

import UIKit
import AVKit
import AVFoundation


class VideoVC: UIViewController {
    
    @IBOutlet weak var playerTrackProgressView: UIProgressView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var avPlayer = AVPlayer()
    var avController  = AVPlayerViewController()
    var volumeSlider = UISlider()
    let playerStack = UIStackView()
    var isPlay : Bool = false
    let playButton = UIButton(type: .system)
    let forwardButton = UIButton(type: .system)
    let backwardButton = UIButton(type: .system)
    var timer: Timer?
    let progressUpdateTimeInterval: TimeInterval = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    deinit {
        timer?.invalidate()
        avPlayer.pause()
    }
}

//MARK: - Actions
extension VideoVC {
    @IBAction func tapToBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Functions
extension VideoVC {
    
    func prepareUI(){
        //setUpAVPlayerController()
        setUpAvPlayer()
    }
    
    //MARK: - This is using AVPlayerViewController To have access By Default Controller
    func setUpAVPlayerController(){
        guard let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else {
            return
        }
        avPlayer = AVPlayer(url: videoURL)
        avController.player = avPlayer
        avController.videoGravity  = .resizeAspect
        avController.view.frame.size.height = playerView.frame.size.height
        avController.view.frame.size.width = playerView.frame.size.width
        self.addChild(avController)
        self.playerView.addSubview(avController.view)
        avPlayer.play()
        isPlay = true
    }
    
    //MARK: - Using Only AVPlayer And Control Should be a Customize
    func setUpAvPlayer(){
        activityIndicator.startAnimating()
        guard let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else {
            activityIndicator.stopAnimating()
            return
        }
        avPlayer = AVPlayer(url:videoURL)
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = playerView.bounds
        playerView.layer.addSublayer(playerLayer)
        activityIndicator.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.configureAVPlayerButton()
        }
        checkState()
    }
    
    func checkState(){
        switch avPlayer.status {
        case .failed:
            print("fails")
        case .readyToPlay:
            print("Ready To Play")
        case .unknown:
            hideAndShowControl()
            avPlayer.play()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(progressViewTapped))
            playerTrackProgressView.addGestureRecognizer(tapGesture)
            playerTrackProgressView.isUserInteractionEnabled = true
            startTimer()
            isPlay = true
            print("Unknowns")
        default:
            print("DEFAULT")
        }
        
    }
    
    func configureAVPlayerButton(){
        let play = UIImage(systemName: "pause.fill")
        let forward = UIImage(systemName: "forward.circle.fill")
        let backward = UIImage(systemName: "backward.circle.fill")
        
        playButton.setImage(play, for: .normal)
        forwardButton.setImage(forward, for: .normal)
        backwardButton.setImage(backward, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        configureStack()
//        configureSlider()
    }
    
    func configureStack(){
        playerStack.axis = .horizontal
        playerStack.distribution = .fillProportionally
        playerStack.alignment = .center
        playerStack.spacing = 0
        playerStack.addArrangedSubview(backwardButton)
        playerStack.addArrangedSubview(playButton)
        playerStack.addArrangedSubview(forwardButton)
        playerStack.frame = CGRect(x: 10, y: playerView.frame.height / 2 - 25, width: playerView.frame.width , height: 50)
      
        playerView.addSubview(playerStack)
        playerView.addSubview(playerTrackProgressView)
//        playerView.addSubview(volumeSlider)
    
        tapViewTapped()
    }
        
    func configureSlider(){
        
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        volumeSlider.translatesAutoresizingMaskIntoConstraints = true
        volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
        volumeSlider.addTarget(self, action: #selector(volumeSliderChanged(_:)), for: .valueChanged)
        volumeSlider.isHidden = true
        volumeSlider.transform = CGAffineTransform(rotationAngle: .pi / 2) 
        
        NSLayoutConstraint.activate([
            volumeSlider.widthAnchor.constraint(equalToConstant: playerView.frame.width),
            volumeSlider.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -20)
        ])
        
    }

    func hideAndShowControl(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewTapped))
        playerView.addGestureRecognizer(tapGesture)
    }
    
    @objc func playButtonTapped() {
        isPlay.toggle()
        isPlay ? avPlayer.play() : avPlayer.pause()
        let play = UIImage(systemName: isPlay ? "pause.fill":"play.fill")
        playButton.setImage(play, for: .normal)
    }
    
    @objc func forwardButtonTapped() {
        let currentTime = avPlayer.currentTime()
        let newTime = CMTimeAdd(currentTime, CMTimeMake(value: 10, timescale: 1))
        avPlayer.seek(to: newTime)
    }
    
    @objc func backwardButtonTapped() {
        let currentTime = avPlayer.currentTime()
        let newTime = CMTimeSubtract(currentTime, CMTimeMake(value: 10, timescale: 1))
        avPlayer.seek(to: newTime)
    }
    @objc func tapViewTapped() {
        playerStack.isHidden = false
        playerTrackProgressView.isHidden = false
        volumeSlider.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.playerStack.isHidden = true
            self.playerTrackProgressView.isHidden = true
            self.volumeSlider.isHidden = true
        }
    }
    
    @objc func startButtonTapped() {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: progressUpdateTimeInterval, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    @objc func updateProgress() {
        let currentTime = avPlayer.currentTime()
        let duration = CMTimeGetSeconds(avPlayer.currentItem!.duration)
        let progress = Float(CMTimeGetSeconds(currentTime) / duration)
        playerTrackProgressView.progress = progress
    }
    
    @objc func progressViewTapped(sender: UITapGestureRecognizer) {
        guard let playerItem = avPlayer.currentItem else {return}
        let tapPoint = sender.location(in: playerStack)
        let maxWidth = playerStack.bounds.width
        let tapPercentage = tapPoint.x / maxWidth
        let newTime = CMTime(seconds: Double(tapPercentage) * CMTimeGetSeconds(playerItem.duration), preferredTimescale: 600)
        avPlayer.seek(to: newTime)
    }
    
    @objc func volumeSliderChanged(_ voumeSider: UISlider) {
        let newVolume = voumeSider.value
        avPlayer.volume = newVolume
    }
}

