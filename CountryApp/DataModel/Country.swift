//
//  Country.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 30/06/23.
//

import Foundation




class Country{
    
    let coatOfArams: CoatOfArms?
    let name: CountryName?
    let isIndependent: Bool
    let isUNNumber: Bool
    let capital: [String]
    let region: String
    let flag:Flag?
    let timeZone: [String]
    var isFav : Bool = false
    
    init(dict: NSDictionary) {
        self.isIndependent = dict.getBooleanValue(key: "independent")
        self.isUNNumber = dict.getBooleanValue(key: "unMember")
        self.capital = dict.getStringArray(key: "capital")
        self.region = dict.getStringValue(key: "region")
        self.timeZone = dict.getStringArray(key: "timezones")
        if let flagDict = dict["flags"] as? NSDictionary {
            self.flag = Flag(dict:flagDict)
        }else {
            self.flag = nil
        }
        if let coatOfAramsDict = dict["coatOfArms"]as? NSDictionary {
            self.coatOfArams = CoatOfArms(dict: coatOfAramsDict)
        }
        else {
            self.coatOfArams = nil
        }
        if let countryNameDict = dict["name"] as? NSDictionary {
            self.name = CountryName(dict: countryNameDict)
        }else {
            self.name = nil
        }
    }
    
}

class Flag {
    
    let flagImag : String
    init(dict: NSDictionary) {
        self.flagImag = dict.getStringValue(key: "png")
    }
    
}

class CountryName {
    let countryName : String
    init(dict: NSDictionary) {
        self.countryName =  dict.getStringValue(key: "common")
    }
}

class CoatOfArms {
    let coatOfArmImg : String
    init(dict: NSDictionary) {
        self.coatOfArmImg = dict.getStringValue(key: "png")
    }
    var imgURL : URL? {
        return URL(string: coatOfArmImg)
    }
}



struct Language {
    let name : String
    let code : String
}
