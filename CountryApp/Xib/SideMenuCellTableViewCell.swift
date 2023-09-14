//
//  SideMenuCellTableViewCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 09/08/23.
//

import UIKit

class SideMenuCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMenuText: UILabel!
    @IBOutlet weak var imgMenuItem: UIImageView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
