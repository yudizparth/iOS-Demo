//
//  DetailVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 06/07/23.
//

import UIKit
import Kingfisher


class DetailVC: UIViewController {
    
    @IBOutlet weak var imgFav: UIButton!
    @IBOutlet weak var txtUNNumber: UILabel!
    @IBOutlet weak var txtRegion: UILabel!
    @IBOutlet weak var txtCapital: UILabel!
    @IBOutlet weak var txtIsIndependent: UILabel!
    @IBOutlet weak var txtCountryName: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    var countryDetail: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
}

//MARK: - Methods
extension DetailVC {
  func prepareUI(){
      let image = UIImage(systemName:  countryDetail?.isFav == true ?"suit.heart.fill" : "suit.heart")
      imgFav.setImage(image, for: .normal)
      let text = countryDetail?.capital.joined(separator: ", ")
      txtRegion.text = countryDetail?.region
      txtCapital.text = text
      txtIsIndependent.text =   countryDetail?.isIndependent == true ? "Yes": "No"
      txtUNNumber.text = countryDetail?.isUNNumber == true ? "Yes": "No"
      txtCountryName.text = countryDetail?.name?.countryName
      imgCountry.kf.setImage(with: countryDetail?.coatOfArams?.imgURL)
    }

}

//MARK: - Actions
extension DetailVC{
    @IBAction func tapTofav(_ sender: UIButton) {
        countryDetail?.isFav.toggle()
        let image = UIImage(systemName:  countryDetail?.isFav == true ?"suit.heart.fill" : "suit.heart")
        imgFav.setImage(image, for: .normal)
    }
    @IBAction func tapToMoveHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapToBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
