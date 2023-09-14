//
//  CountryData.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 05/09/23.
//

import Foundation

struct CountryData{
    var countryName : String
    var code : String
    
    init(dict : NSDictionary) {
        self.countryName = dict.getStringValue(key: "name")
        self.code = dict.getStringValue(key:"dial_code")
    }
}
