//
//  LoginVCViewController.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 05/09/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.register(LoginBannerCellTableViewCell.nib, forCellReuseIdentifier: LoginBannerCellTableViewCell.loginBanner)
        tableView.register(LoginViewCell.nib, forCellReuseIdentifier: LoginViewCell.loginCell)
    }
}

//MARK: - Delegate And DataSource
extension LoginVC  :  UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginBannerCellTableViewCell.loginBanner, for: indexPath) as! LoginBannerCellTableViewCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginViewCell.loginCell, for: indexPath) as! LoginViewCell
            cell.buttonTapCallback = {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeVC
                self.navigationController?.pushViewController(homeViewController, animated: true)
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        else {
            return 250
        }
    }
    
}




