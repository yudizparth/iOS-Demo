//
//  HeaderViewCollectionReusableView.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 31/08/23.
//

import UIKit

class HeaderViewCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerTitle : UILabel!
    
    class var headerCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: headerCell, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
