//
//  SearchMovieVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 20/07/23.
//

import UIKit
import Kingfisher

class SearchMovieVC: UIViewController {
    var webSeriesList: [Webseries]! = []

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}

extension SearchMovieVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webSeriesList.isEmpty ? 1 :webSeriesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return webSeriesList.isEmpty ?  ((tableView.window?.frame.height)!) - 70  : 60
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (webSeriesList.isEmpty){
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataTblCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "webSeriesCell", for: indexPath) as! SearchMovieCell
            cell.imgMovie.kf.setImage(with: webSeriesList[indexPath.row].image?.posterImageURL)
            cell.txtName.text = webSeriesList[indexPath.row].seriesName
            cell.txtLanguage.text = webSeriesList[indexPath.row].language
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if webSeriesList.isEmpty{
            return
        }
        let webSeriesData = webSeriesList[indexPath.row]
        performSegue(withIdentifier: "webSeriesDetails", sender: webSeriesData)
    }
    
}

//MARK: - Methods
extension SearchMovieVC {
    func prepareUI(){
        tableview.register(UINib(nibName: "NoDataTblCell", bundle: nil), forCellReuseIdentifier: "noDataCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WebSeriesDetailVC {
            vc.webSeriesDetail = sender as! Webseries
        }
    }
    
    func reload(){
        tableview.reloadData()
    }
    
    func searchWebSeries(searchString : String){
        APIManager.shareInstance.searchWebSeries(searchText: searchString){ (result) in
            switch result {
            case .success(let json):
                self.webSeriesList = []
                if let arr = (json as? [NSDictionary]){
                    for dict in arr {
                        let data = Webseries(dict: dict["show"] as! NSDictionary)
                        self.webSeriesList.append(data)
                    }
                    self.reload()
                }
                break
            case .failure(let error):
                print("Error is error ",error)
            }
        }
    }
    
}


// MARK: - UITextFieldDelegate methods
extension SearchMovieVC : UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count >= 3 {
            let newText = textField.text!.replacingOccurrences(of: " ", with: "%20")
            self.searchWebSeries(searchString: newText)
        }else if textField.text!.count == 0  {
            webSeriesList = []
            reload()
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        reload()
        return true
    }
    
}


//MARK: - Table View Cell
class SearchMovieCell : UITableViewCell {
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var txtLanguage: UILabel!
    @IBOutlet weak var txtName: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
