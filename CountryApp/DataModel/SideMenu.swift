//
//  SideMenu.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 09/08/23.
//

import Foundation
import UIKit

struct SideMenuModel {
    var icon: UIImage
    var title: String
}

//MARK: -DataAdd

var menu : [SideMenuModel] = [
    SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Core-Data"),
    SideMenuModel(icon: UIImage(systemName: "music.note")!, title: "TBL-Diffable"),
    SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Composition Layout"),
    SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "MVVM"),
    SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "WebKit"),
    SideMenuModel(icon: UIImage(systemName: "pencil.slash")!, title: "Select Language"),
    SideMenuModel(icon: UIImage(systemName: "circles.hexagonpath.fill")!, title: "Animation"),
    SideMenuModel(icon: UIImage(systemName: "video.fill")!, title: "Video Player"),
    SideMenuModel(icon: UIImage(systemName: "camera.circle")!, title: "Camera"),
    SideMenuModel(icon: UIImage(systemName: "applelogo")!, title: "Logout")
]
