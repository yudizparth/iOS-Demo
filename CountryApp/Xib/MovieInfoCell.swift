//
//  MovieInfoCell.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 22/08/23.
//

import UIKit

class MovieInfoCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieGeners: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    class var movieInfo: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: movieInfo, bundle: nil) }
    
    var movieInfoData : MovieInfo! {
        didSet{
            movieName.text = movieInfoData.movieName
            movieLanguage.text = movieInfoData.language
            movieGeners.text = movieInfoData.movieGener
            if let imageData = movieInfoData.moviePoster, let image = UIImage(data: imageData) {
                moviePoster?.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
