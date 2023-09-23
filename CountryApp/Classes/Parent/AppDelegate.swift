//
//  AppDelegate.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 29/06/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func checkAuthentication() -> Bool {
        return Config.userDefault.bool(forKey: "authorization")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if var appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            appName = AppHelper.shared.getLocalizeString(str: "CFBundleDisplayName")
        }

        DispatchQueue.main.async {
            self.checkUserLogedin()
        }

        DispatchQueue.main.async {
            self.checkLanguage()
        }
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func checkLanguage(){
        let components = Locale.components(fromIdentifier: Locale.preferredLanguages.first!)
        if let languageCode = components[NSLocale.Key.languageCode.rawValue] {
            Config.userDefault.set(languageCode, forKey: "Language")
            Config.userDefault.synchronize()
        }
        if Config.userDefault.string(forKey: "Language") == "gu"
        {
            AppHelper.shared.setLanguage("gu")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else if Config.userDefault.string(forKey: "Language") == "hi"
        {
            AppHelper.shared.setLanguage("hi")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else if Config.userDefault.string(forKey: "Language") == "ar"
        {
            AppHelper.shared.setLanguage("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            AppHelper.shared.setLanguage("en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            print("Selected Language English")
        }
    }
    
    func checkUserLogedin(){
        Config.userDefault.synchronize()
        let isAuth = checkAuthentication()
        if isAuth {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeVC
            let navController = Config.appDelegator.window?.rootViewController as! UINavigationController
            navController.viewControllers = [homeVC]
            Config.appDelegator.window?.rootViewController = navController
        } else {
            let storyboard = UIStoryboard(name: "Entry", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            let navController = Config.appDelegator.window?.rootViewController as! UINavigationController
            navController.viewControllers = [loginViewController]
            Config.appDelegator.window?.rootViewController = navController
        }
    }
}

