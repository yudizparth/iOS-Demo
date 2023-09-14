//
//  ProductCellTableViewCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 28/08/23.
//

import UIKit
import Kingfisher


class ProductCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fotterView: UIView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var priceLbel: UILabel!
    @IBOutlet weak var productDiscriptionLbl: UILabel!
    @IBOutlet weak var productCategoriesLbl: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var product : Product? {
        didSet{
            productTitleLabel.text = product?.title
            productCategoriesLbl.text = product?.category
            priceLbel.text = "\(product!.price)"
            productDiscriptionLbl.text = product?.description
            imgProduct.kf.setImage(with: product?.productImage)
            rateButton.setTitle("\(product!.rating!.rate)", for: .normal)
        }
    }
    
    
    
    class var productCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: productCell, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 12
        imgProduct.layer.cornerRadius = 8
        fotterView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapToBye(_ sender: UIButton) {
        
    }
}
