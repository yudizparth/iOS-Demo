//
//  ProductCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 31/08/23.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    class var productCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: productCell, bundle: nil) }
    
    @IBOutlet weak var imgProduct : UIImageView!
    @IBOutlet weak var lblProductName : UILabel!
    @IBOutlet weak var productView : UIView!
    @IBOutlet weak var lblRating : UILabel!
    @IBOutlet weak var lblDes : UILabel!
    @IBOutlet weak var lblTag : UILabel!
    @IBOutlet weak var lblBenefitDesc : UILabel!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var cornerView : UIView!
    @IBOutlet weak var lblDelivertFree : UILabel!
    
    
    var setData : RestaurantListModel!{
        didSet{
            imgProduct.image = UIImage(named: setData.restaurantCoverImage)
            lblProductName.text = setData.restaurantName
            lblRating.text = "Rating: \(setData.rating)"
            lblRating.text = "Rating: \(setData.rating)"
            lblDes.text = setData.description
            lblTag.text = setData.tags
            lblTime.text = "Time: \(setData.time)"
            lblDelivertFree.text = "\(setData.rating)"        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cornerView.layer.cornerRadius = 20
        cornerView.layer.masksToBounds = true
        cornerView.layer.maskedCorners = [.layerMinXMaxYCorner]
        lblDelivertFree.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4) // Adjust the angle as needed

    }

}
