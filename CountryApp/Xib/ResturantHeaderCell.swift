//
//  ResturantHeaderCellCollectionReusableView.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 01/09/23.
//

import UIKit

class ResturantHeaderCell: UICollectionReusableView {
    
    class var headerCell: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: headerCell, bundle: nil) }
    
    lazy var allRestaurants : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label.withAlphaComponent(0.8)
        label.text = "All Categories".uppercased()
        label.font = UIFont(name: "Sailors Condensed", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "BackgroundColor")

        [allRestaurants].forEach{addSubview($0)}
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstrains(){
            
        NSLayoutConstraint.activate([
            allRestaurants.centerYAnchor.constraint(equalTo: centerYAnchor),
            allRestaurants.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            allRestaurants.rightAnchor.constraint(equalTo: rightAnchor, constant: 20)
        ])
        
    }
}
