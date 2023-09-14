//
//  ProductCategoriesCellCollectionViewCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 01/09/23.
//

import UIKit

class ProductCategoriesCell: UICollectionViewCell {
    
    class var categoriesCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: categoriesCell, bundle: nil) }
    
    @IBOutlet weak var imgOffer : UIImageView!
    @IBOutlet weak var lblCategories : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
