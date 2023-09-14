//
//  FavVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 11/07/23.
//

import UIKit

class FavVC: UIViewController {
    var countryDataList: [Country] = []
    var favDataList: [Country] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favDataList = countryDataList.filter{$0.isFav == true}
        tableView.register(UINib(nibName: "NoDataTblCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
    }
    
}

//MARK: - Actions
extension FavVC {
    
    
    @IBAction func tapToMoveHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapToBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - TableViewDeleGate & DataSource Methods
extension FavVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favDataList.isEmpty ? 1 : favDataList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (favDataList.isEmpty){
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataTblCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavCell
            
            cell.parentVC = self
            cell.country = favDataList[indexPath.row]
            cell.prepareCellUI()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return favDataList.isEmpty ?  ((tableView.window?.frame.height)!) - 60  : 80
    }

}

extension FavVC {
    func reloadData(){
        favDataList = favDataList.filter{$0.isFav == true}
        tableView.reloadData()
    }
}


//MARK: - TableViewCell
class FavCell : UITableViewCell{

    @IBOutlet weak var btnTapToFav: UIButton!
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    
    var country : Country!
    var parentVC : FavVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

//MARK: - Action
extension FavCell{
    
    @IBAction func tapTo(_ sender: Any) {
        country.isFav.toggle()
        parentVC.reloadData()
    }
    
}

//MARK: -PrapareUI
extension FavCell {
    
    func prepareCellUI(){
        lblCountryName.text = country.name?.countryName
        imgCountryFlag.kf.setImage(with: country.coatOfArams?.imgURL)
    }
    
}

