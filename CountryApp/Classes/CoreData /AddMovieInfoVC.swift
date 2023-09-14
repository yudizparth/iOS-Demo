//
//  CollectionViewVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 16/08/23.
//

import UIKit


class AddMovieInfoVC: UIViewController{
   
    var movieList : [MovieInfo] = []
    var languagePickerView: UIPickerView!
    let languageData = ["Hindi", "English", "Tamil","Telugu","Gujarati" ,"Kannad"]
    var imagePicker = UIImagePickerController()
    var addInfoCell: AddMovieInfoCell!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.sourceType =  .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.tableView.register(AddMovieInfoCell.nib, forCellReuseIdentifier: AddMovieInfoCell.addInfoCell)
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        movieList = DataBaseHelper.sharedInstace.fetchData()
        languagePickerView = UIPickerView()
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ((addInfoCell?.isUpdate) != nil){
            addInfoCell.txtLanguage.text = ""
            addInfoCell.txtName.text = ""
            addInfoCell.txtGener.text = ""
        }
    }
  
}

//MARK: - TableVIew Delegate and DataSource
extension AddMovieInfoVC  : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddMovieInfoCell.addInfoCell, for: indexPath) as! AddMovieInfoCell
        cell.viewController = self
        return cell
    }
   
}

//MARK: - Actions
extension AddMovieInfoVC   {
    @IBAction func  tapToBack (_ sender : UIButton){
        navigationController?.popToRootViewController(animated: true)
    }
}

//MARK: - PickerView DataSource and Delegate
extension AddMovieInfoVC : UIPickerViewDelegate , UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return languageData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = languageData[row]
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let cell = tableView.cellForRow(at: selectedIndexPath) as? AddMovieInfoCell
            cell?.txtLanguage.text = selectedValue
        }
    }
      
}
