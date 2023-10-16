//
//  ViewController.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 29/06/23.
//

import UIKit
import Kingfisher

class CountryListVC: UIViewController {
    var countryDataList: [Country]! = []
    var searchData: [Country] = []
    let customLoader = CustomLoaderToRotate.initwith()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setCustomLoader()
        fetchData()
    }
}

//MARK: -Methods
extension CountryListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailVC {
            vc.countryDetail = sender as! Country
        }else if let vc = segue.destination as? FavVC{
            vc.countryDataList = searchData
        }
    }
    
    func setCustomLoader(){
        customLoader.center = self.view.center
        self.view.addSubview(customLoader)
    }
    
    func searchCountryData(searchString : String){
        customLoader.startAnimating()
        APIManager.shareInstance.searchCountry(searchText: searchString) { (result) in
            self.countryDataList = []
            switch result {
            case .success(let json):
                if let arr = (json as? [NSDictionary]){
                    for dict in arr {
                        let data = Country(dict: dict)
                        self.countryDataList.append(data)
                    }
                }
                self.reload()
            case .failure(let error):
                print("Error is error ",error)
                self.reload()
            }
        }
    }
    
    //MARK: -Searching Locally
    func filterData(with searchText: String?) {
        if let searchText = searchText, !searchText.isEmpty {
            searchData = countryDataList.filter {($0.name?.countryName.localizedCaseInsensitiveContains(searchText))!}
        } else {
            searchData = countryDataList
        }
        self.reload()
        
    }
    
    func fetchData(){
        tableView.register(UINib(nibName: "NoDataTblCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
        searchTextField.delegate = self
        customLoader.startAnimating()
        APIManager.shareInstance.getCountryData{ (result) in
            self.countryDataList = []
            switch result {           
            case .success(let json):
                if let arr = (json as? [NSDictionary]){
                    for dict in arr {
                        let slider = Country(dict: dict)
                        self.countryDataList.append(slider)
                    }
                    self.searchData = self.countryDataList
                }
            
                self.reload()
                break
            case .failure(let error):
                self.reload()
                print("Error is error ",error)
            }
        }
    }
    
    func reload(){
        customLoader.stopAnimating()
        tableView.reloadData()
    }
    
}

//MARK: - TableView Methods
extension CountryListVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.isEmpty ? 1 : searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (searchData.isEmpty){
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataTblCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryCell
            cell.lblCountryName.text = searchData[indexPath.row].name?.countryName
            cell.imgCountry.kf.setImage(with: searchData[indexPath.row].coatOfArams?.imgURL)
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return searchData.isEmpty ?  ((tableView.window?.frame.height)!) - 60  : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchData.isEmpty{
            return
        }
        let countryDate = searchData[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: countryDate)
    }
}

// MARK: - UITextFieldDelegate methods
extension CountryListVC : UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.filterData(with: textField.text)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        reload()
        return true
    }
    
    @IBAction func tapToFav(_ sender: Any) {
        performSegue(withIdentifier: "navigateToFav", sender: self)
    }
    
    //MARK: - Searching Using Api
    @IBAction func txtSearch(_ sender: UITextField) {
//        searchCountryData( searchString: sender.text! )
        
    }
    
}

//MARK: - Table view cell
class CountryCell : UITableViewCell {
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    override class func awakeFromNib() {
        
    }
    
}

