//
//  CustomTost.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 13/09/23.
//

import UIKit

class CustomTostView: UIView {
    
    @IBOutlet private var messageLabel: UILabel!
        
    class func showToast(message: String, inView view: UIView) {
        
        let toastView = UINib(nibName: "ToastView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CustomTostView
        toastView.messageLabel.text = message

        toastView.alpha = 0
        view.addSubview(toastView)

        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, animations: {
                toastView.alpha = 0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}
