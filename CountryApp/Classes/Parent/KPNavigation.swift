//
//  KPNavigation.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 11/09/23.
//

import UIKit

class KPNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isUserLogedIn = false
//        if isUserLogedIn {
//            perform(#selector(showHome) , with: nil ,afterDelay: 0.01)
//
//        }else {
//            perform(#selector(shwoLogin), with: nil ,afterDelay: 0.01)
//        }
    }
   
}

extension KPNavigationViewController {
    
    @objc  func shwoLogin(){
        let loginVC = LoginVC()
        present(loginVC, animated: true) {
            //Latter We add Logic
        }
    }
    
    @objc func showHome(){
        let homeVC = HomeVC()
        viewControllers =  [homeVC]
//        present(homeVC, animated: true) {
//        }
    }
}
