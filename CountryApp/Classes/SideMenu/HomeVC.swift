//
//  HomeVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 09/08/23.
//

import UIKit

class HomeVC: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    @IBOutlet weak var usetNamelbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var isSideView : Bool = false

    var menu: [SideMenuModel] = [
           SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Core-Data"),
           SideMenuModel(icon: UIImage(systemName: "music.note")!, title: "TBL-Diffable"),
           SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Composition Layout"),
           SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "MVVM"),
           SideMenuModel(icon: UIImage(systemName: "beats.powerbeatspro.chargingcase.fill")!, title: "WebKit"),
           SideMenuModel(icon: UIImage(systemName: "pencil.slash")!, title: "Select Language"),
           SideMenuModel(icon: UIImage(systemName: "hand.thumbsup.fill")!, title: "Like us on facebook"),
           SideMenuModel(icon: UIImage(systemName: "applelogo")!, title: "Logout")
       ]

 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SideMenuCellTableViewCell.nib, forCellReuseIdentifier: SideMenuCellTableViewCell.identifier)
        isSideView = false
        tableView.isHidden = true
        headerView.isHidden = true
        tableView.estimatedRowHeight = 80
        let greeting = LocalizationManager.shared.localizedString("Parth Prajapati")
        usetNamelbl.text =  greeting
        selectedSegment.selectedSegmentIndex = MTUserDefault.shared.theme.rawValue
        print( MTUserDefault.shared.theme.rawValue)
    }
    

    @IBAction func tapToChnageTheme(_ sender: UISegmentedControl) {
        MTUserDefault.shared.theme = Theme(rawValue: selectedSegment.selectedSegmentIndex)!
        self.view.window?.overrideUserInterfaceStyle = MTUserDefault.shared.theme.getUserInterface()
    }
    
    @IBAction func onTapMenuBar (_ sender : UIButton){
        tableView.isHidden = false
       
        self.view.bringSubviewToFront(tableView)
        if !isSideView{
            UIView.animate(withDuration: 1.0) { [self] in
                headerView.isHidden = false
                self.isSideView = true
                self.tableViewWidth.constant = 240
            }
        }else {
            UIView.animate(withDuration: 1.0) {
                self.headerView.isHidden = true
                self.isSideView = false
                self.tableViewWidth.constant = 0
            }
        }
    }
}


//MARK: - Methods
extension HomeVC  : UITableViewDataSource , UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCellTableViewCell.identifier, for: indexPath) as? SideMenuCellTableViewCell else { fatalError("xib doesn't exist") }
        cell.imgMenuItem.image = self.menu[indexPath.row].icon
        cell.lblMenuText.text = self.menu[indexPath.row].title
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
            navigationController?.pushViewController( vc , animated: true)
        }
        else {
            let storyboard = UIStoryboard(name: "Entry", bundle: nil)
            let  logoutVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            Config.userDefault.set(false, forKey: "authorization")
            navigationController?.pushViewController( logoutVC , animated: true)
        }
    }
    
    func setDarkMode() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
    }

    func setLightMode() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
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


