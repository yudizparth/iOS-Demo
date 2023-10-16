//
//  File.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 16/10/23.
//

import AVFoundation
import UIKit


class PermissionHelper {
    
    static var shared = PermissionHelper()
    
    func getPermission(){
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("Camera access is granted.")
            } else {
                print("Camera access is denied.")
            }
        }
    }
    
    func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined :
            PermissionHelper.shared.getPermission()
            break
        case .denied :
            PermissionHelper.shared.getPermission()
            break
        case .restricted :
            print("restricted ")
            break
        case .authorized :
            print("authorized")
            break
        default :
            break
        }
    }
    
    func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
    }
}
