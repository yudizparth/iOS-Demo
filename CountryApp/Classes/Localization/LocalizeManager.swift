//
//  LocalizeManager.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 14/09/23.
//

import Foundation



var languageList : [Language] =  [
    Language(name: "Gujarati", code: "gu"),
    Language(name: "Hindi", code: "hi"),
    Language(name: "English", code: "en")
]


//MARK: - Localization  Methods
class AppHelper : NSObject {
    
    static let shared = AppHelper()
    
    func getLocalizeString(str:String) -> String {
        let string = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "Language"), ofType: "lproj")
        let myBundle = Bundle(path: string!)
        return (myBundle?.localizedString(forKey: str, value: "", table: nil))!
    }
    
    func setLanguage(_ languageCode: String) {
        Config.userDefault.set(languageCode, forKey: "Language")
        Config.userDefault.synchronize()
    }
    
    
}

private var bundleKey: UInt8 = 0

class LocalizationManager {
    static let shared = LocalizationManager()
    private init() {}
    
    func setLanguage(_ languageCode: String) {
        Config.userDefault.set(languageCode, forKey: "Language")
        Config.userDefault.synchronize()
    }
    
    func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension Bundle {
    static func setLanguage(_ languageCode: String) {
        defer { object_setClass(Bundle.main, self) }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: Bundle.main.path(forResource: languageCode, ofType: "lproj")!), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}


