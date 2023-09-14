//
//  WebSeriesDetailVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 03/08/23.
//

import UIKit

class WebSeriesDetailVC: UIViewController {
    var webSeriesDetail : Webseries?

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
}

//MARK: - Methods 
extension WebSeriesDetailVC{
    func prepareUI(){
        tableview.estimatedRowHeight = 600
        tableview.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func tapToBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SeasonInfoVC {
            vc.id = webSeriesDetail?.id
        }
    }
    
    
    @IBAction func  showSeason(_ sender : UIButton){
        performSegue(withIdentifier: "SeriesEpisode", sender: sender)
    }
}


//MARK: - TableView Delegate and Data Source
extension WebSeriesDetailVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "webSeriesDetail", for: indexPath) as! webSeriesesDetailCell
        cell.imgPoster.kf.setImage(with: webSeriesDetail?.image?.posterImageURL)
        cell.lblSeriesName.text = webSeriesDetail?.seriesName
        cell.lblLanguage.text =  webSeriesDetail!.language
        cell.lblSummary.text = removePTags(from:webSeriesDetail!.summary)
        cell.lblGeners.text = webSeriesDetail?.genres.joined(separator: ", ")
        cell.lblDuration.text = webSeriesDetail?.runtime?.averageRuntime 
        cell.lblStatus.text = webSeriesDetail?.status
        return cell
    }

}


class webSeriesesDetailCell : UITableViewCell {

    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblGeners: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblSeriesName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
