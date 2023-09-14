//
//  MyCollectionViewCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 29/08/23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    class var myCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: myCell, bundle: nil) }
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var view : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
