//
//  LoginBannerCellTableViewCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 05/09/23.
//

import UIKit

class LoginBannerCellTableViewCell: UITableViewCell {

    class var loginBanner: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: loginBanner, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
