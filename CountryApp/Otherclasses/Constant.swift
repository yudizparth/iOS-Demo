//
//  Constant.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 30/06/23.
//

import Foundation
import UIKit

let base_url = "https://restcountries.com"
let countryList = "\(base_url)/v3.1/all"
let searchCountryURL = "\(base_url)/v3.1/name/"

let base_url_webseries = "https://api.tvmaze.com/search"
let base_url_episode = "https://api.tvmaze.com/"
let searchWebSeriesURL = "\(base_url_webseries)/shows"
let episodeURL = "\(base_url_episode)seasons"

let appleURL = URL(string:"https://www.apple.com")
let googleURL = URL(string:"https://www.GOOGLE.com")
let flutterURL = URL(string:"https://flutter.dev/")

let productURL = "https://fakestoreapi.com/products"
let  htmlContent = """
<html>
<head>
  <h1>
    <b>
    The document title and other information used by search engines.
  </b></h1>
   
</head>
<body>
<h1>
<b>
    all the text and instructions for the document </b></h1>
</body>
</html>
"""

enum UserSection {
    case first
}

//MARK: - Debug Print
func kprint(items: Any...) {
#if DEBUG
    for item in items {
        print(item)
    }
#endif
}



struct Config {
    
    static let screenFrame = UIScreen.main.bounds
    static var userDefault = UserDefaults.standard
    static let appDelegator = UIApplication.shared.delegate! as! AppDelegate
}

/*---------------------------------------------------
 Place Holder image
 ---------------------------------------------------*/
struct PlaceHolder {
    static let noImage = UIImage(named: "noImage")
}

struct MTUserDefault {
    static var shared = MTUserDefault()

    var theme : Theme{
        get {
            return Theme(rawValue: Config.userDefault.integer(forKey: "SelectedTheme")) ?? .device
        }
        set{
            Config.userDefault.set(newValue.rawValue , forKey : "SelectedTheme")
            Config.userDefault.synchronize()
        }
    }
}

extension String {
    func localizableString(loc : String) -> String {
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
