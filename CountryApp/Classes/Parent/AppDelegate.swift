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
        return UserDefaults.standard.bool(forKey: "authorization")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        let isAuth = checkAuthentication()
        
        DispatchQueue.main.async {
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

        if  Config.userDefault.string(forKey: "Language") != nil && Config.userDefault.string(forKey: "Language")! == "gu"
        {
            LocalizationManager.shared.setLanguage("gu")
            print("gu")
        }
        else  if Config.userDefault.string(forKey: "Language") != nil && Config.userDefault.string(forKey: "Language")! == "hi"
        {
            
            LocalizationManager.shared.setLanguage("hi")
            print("hi")
        }
        else
        {
            LocalizationManager.shared.setLanguage("en")
            print("en")
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
}

