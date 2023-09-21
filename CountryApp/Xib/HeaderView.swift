//
//  HeaderView.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 21/09/23.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblUserName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white // Set your desired color here
        self.backgroundView = backgroundView
    }
}
