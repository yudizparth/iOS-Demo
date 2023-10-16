//
//  VideoPlayerCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 27/09/23.
//

import UIKit
import AVFoundation

class VideoPlayerCell: UITableViewCell {
    @IBOutlet weak var videoPlayerView: UIView!
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    var videoFileName: String? {
        didSet {
            guard let videoFileName = videoFileName else { return }
            if let videoURL = Bundle.main.url(forResource: videoFileName, withExtension: "mp4") {
                player = AVPlayer(url: videoURL)
                playerLayer = AVPlayerLayer(player: player)
                playerLayer?.frame = contentView.bounds
                playerLayer?.videoGravity = .resizeAspect
                videoPlayerView.layer.addSublayer(playerLayer!)
            }
        }
    }
    
    func playVideo() {
        player?.play()
    }
    func pauseVideo() {
        player?.pause()
    }
    
}
