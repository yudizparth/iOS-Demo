//
//  EpisodeInfoVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 08/08/23.
//

import UIKit

class EpisodeInfoVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var episodeInfo : Webseries!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

//MARK: -Methods
extension EpisodeInfoVC {
    
    @IBAction func tapToMoveHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func tapToBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView Methods
extension EpisodeInfoVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as! EpisodeCell
        cell.imgPoster.kf.setImage(with: episodeInfo.image?.posterImageURL,placeholder: PlaceHolder.noImage)
        cell.lblSeriesName.text = episodeInfo.seriesName
        cell.lblEpisodeNo.text = episodeInfo.numberOfEpisode
        cell.lblSeriesNo.text = episodeInfo.seasonNo
        cell.lblSummary.text = removePTags(from:episodeInfo.summary)
        cell.lblRating.text = episodeInfo.runtime?.averageRuntime
        return cell
    }
}

//MARK: - Custom Cell
class EpisodeCell : UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblEpisodeNo: UILabel!
    @IBOutlet weak var lblSeriesNo: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblSeriesName: UILabel!
}
