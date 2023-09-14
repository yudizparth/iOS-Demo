//
//  SeasonInfoVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 07/08/23.
//

import UIKit

class SeasonInfoVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var episodeArray : [Webseries]! = []
    
    var id : String?
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}

//MARK: - Methods
extension SeasonInfoVC {
    @IBAction func tapToback(_ sender : UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EpisodeInfoVC {
            vc.episodeInfo = sender as! Webseries
        }
    }
    
    func prepareUI(){
        collectionView.register(UINib(nibName: "NoDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoDataCell")
        getEpisodeData()
    }
    func getEpisodeData(){
        APIManager.shareInstance.getEpisodes(id: id!){ (result) in
            switch result {
            case .success(let json):
                self.episodeArray = []
                if let arr = (json as? [NSDictionary]){
                    for dict in arr {
                        let data = Webseries(dict: dict)
                        self.episodeArray.append(data)
                    }
                    self.collectionView.reloadData()
                }
                break
            case .failure(let error):
                self.episodeArray = []
                self.collectionView.reloadData()
                print("Error is error ",error)
            }
        }
    }
}

//MARK: - CollectionView Delegate And DataSource
extension SeasonInfoVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeArray.isEmpty ? 1 :episodeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if episodeArray.isEmpty{
            return
        }
        let webSeriesData = episodeArray[indexPath.row]
        performSegue(withIdentifier: "episodeInfo", sender: webSeriesData)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if episodeArray.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoDataCell", for: indexPath) as! NoDataCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seasonInfoCell", for: indexPath) as! SeriesInfoCell
            cell.lblLaunchDate.text = "Premier Date: \(episodeArray[indexPath.row].premierDate)"
            cell.lblWebseriesName.text = "\(episodeArray[indexPath.row].seriesName)"
            cell.lblNumberOfEpisode.text = "Episode No:\(episodeArray[indexPath.row].numberOfEpisode)"
             
            cell.imgSeasonPoster.kf.setImage(with: episodeArray[indexPath.row].image?.posterImageURL,placeholder: PlaceHolder.noImage)
            return cell
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension SeasonInfoVC  : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 20 , height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}


class SeriesInfoCell : UICollectionViewCell {
    @IBOutlet weak var seasonView: UIView!
    @IBOutlet weak var lblNumberOfEpisode: UILabel!
    @IBOutlet weak var lblLaunchDate: UILabel!
    @IBOutlet weak var lblWebseriesName: UILabel!
    @IBOutlet weak var imgSeasonPoster: UIImageView!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
   
    func setupUI() {
        seasonView.layer.cornerRadius = 10.0
        seasonView.layer.borderWidth = 2.0
        seasonView.layer.borderColor = UIColor.clear.cgColor
    }
    
}
