//
//  CommonDialiog.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 22/08/23.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func addDataAlert(title: String, message: String ,completion: @escaping (String?) -> Void) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addTextField ()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let textField = alertController.textFields?.first
            completion(textField?.text)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        return alertController
    }
    
    static func updateDataAlert(title: String, message: String ,value : String,completion: @escaping (String?) -> Void) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addTextField { textField in
              textField.text = value
          }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let textField = alertController.textFields?.first
            completion(textField?.text)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        return alertController
    }

}
