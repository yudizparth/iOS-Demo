//
//  HomeVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 09/08/23.
//

import UIKit

class HomeVC: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var btnWebSeries: UIButton!
    @IBOutlet weak var btnCountryDemo: UIButton!
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    @IBOutlet weak var usetNamelbl: UILabel!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var isSideView : Bool = false

    //MARK: - AddObserver Added.
    //MARK: - UnComment Applying Using App Delegater Method Root Reload Method.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SideMenuCellTableViewCell.nib, forCellReuseIdentifier: SideMenuCellTableViewCell.identifier)
        self.tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        isSideView = false
        tableView.isHidden = true
        tableView.estimatedRowHeight = 80
        selectedSegment.selectedSegmentIndex = MTUserDefault.shared.theme.rawValue
        Config.defaultCenter.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name.changeLanguage, object: nil)
        isArebic()
        updateLanguage()
       
    }

}

//MARK: - Actions
extension HomeVC {
    
    @IBAction func tapToChnageTheme(_ sender: UISegmentedControl) {
        MTUserDefault.shared.theme = Theme(rawValue: selectedSegment.selectedSegmentIndex)!
        self.view.window?.overrideUserInterfaceStyle = MTUserDefault.shared.theme.getUserInterface()
    }
    
    @IBAction func onTapMenuBar (_ sender : UIButton){
        tableView.isHidden = false
        
        self.view.bringSubviewToFront(tableView)
        if !isSideView{
            UIView.animate(withDuration: 2.0) { [self] in
                self.isSideView = true
                self.tableViewWidth.constant = 240
            }
        }else {
            UIView.animate(withDuration: 2.0) {
                self.isSideView = false
                self.tableViewWidth.constant = 0
            }
        }
    }
}

extension HomeVC{
    //MARK: - Obsever Function Set
    @objc func updateLanguage(){
        let nameWebseries = AppHelper.shared.getLocalizeString(str: "Country List Demo")
        let nameCountry = AppHelper.shared.getLocalizeString(str: "Search TV Series and Show  Detail")
        btnWebSeries.setTitle(nameWebseries, for: .normal)
        btnCountryDemo.setTitle(nameCountry, for:  .normal)
        isArebic()
        tableView.reloadData()
    }
    
    @objc func isArebic(){
        if Config.userDefault.string(forKey: "Language") == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}

//MARK: -Table View Methods
extension HomeVC  : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCellTableViewCell.identifier, for: indexPath) as? SideMenuCellTableViewCell else { fatalError("xib doesn't exist") }
        cell.imgMenuItem.image = menu[indexPath.row].icon
        cell.lblMenuText.text = menu[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let collectionVC : AddMovieInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "collectionVC") as! AddMovieInfoVC
            navigationController?.pushViewController(collectionVC, animated: true)
        }else if indexPath.row == 1 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "tblDiffable") as! TableViewDiffableVC
            navigationController?.pushViewController( vc , animated: true)
        }
        else if indexPath.row == 2 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "compositionalLY") as! CompositionalLayoutVC
            navigationController?.pushViewController( vc , animated: true)
        }
        else if indexPath.row == 3 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "productList") as! ProductListVC
            navigationController?.pushViewController( vc , animated: true)
        }
        else if indexPath.row == 4 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "WebKit") as! WebKitVC
            navigationController?.pushViewController( vc , animated: true)
        }
        else if indexPath.row == 5 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "Localization") as! LocalizationVC
            navigationController?.pushViewController(vc , animated: true)
        }
        else if indexPath.row == 6 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "Animation") as! AnimationVC
            navigationController?.pushViewController(vc , animated: true)
        }
        else if indexPath.row == 7 {
            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "VideoID") as! VideoVC
            navigationController?.pushViewController(vc , animated: true)
        }
        else {
            let storyboard = UIStoryboard(name: "Entry", bundle: nil)
            let  logoutVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            Config.userDefault.set(false, forKey: "authorization")
            navigationController?.pushViewController( logoutVC , animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.lblUserName.text = AppHelper.shared.getLocalizeString(str: "Parth Prajapati")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform  = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 2.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }

}


extension AddMovieInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("Working Fine......",selectedImage)
        } else {
            print("Not Working.....")
        }
    }
}


