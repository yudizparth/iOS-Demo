//
//  VideoDemo.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 27/09/23.
//

import UIKit
import AVFoundation

class VideoDemo: UIViewController {
    let videoURLs = ["1", "2", "3", "4","5","6"]
    //    let videoURLs = ["https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"]
    var avPlayers = [AVPlayer]()
    var avPlayerLayers = [AVPlayerLayer]()
    var currentlyPlayingCell: VideoPlayerCell?

    
    @IBOutlet weak var videoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.register(UINib(nibName: "VideoPlayerCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        
        prepareUI()
    }
    
}


extension VideoDemo : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! VideoPlayerCell
        cell.videoFileName = videoURLs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let center = CGPoint(x: videoTableView.center.x + videoTableView.contentOffset.x, y: videoTableView.center.y + videoTableView.contentOffset.y)
        let center =  CGPoint(x: videoTableView.bounds.midX, y: videoTableView.bounds.midY)
        if let indexPath = videoTableView.indexPathForRow(at: center) {
            let cell = videoTableView.cellForRow(at: indexPath) as! VideoPlayerCell
            if cell != currentlyPlayingCell {
                currentlyPlayingCell?.pauseVideo()
                cell.playVideo()
                currentlyPlayingCell = cell
            }
        }
    }
}

extension VideoDemo {
    func prepareUI(){
        for _ in videoURLs {
            let avPlayer = AVPlayer()
            avPlayers.append(avPlayer)
            let avPlayerLayer = AVPlayerLayer(player: avPlayer)
            avPlayerLayers.append(avPlayerLayer)
        }
    }
}
