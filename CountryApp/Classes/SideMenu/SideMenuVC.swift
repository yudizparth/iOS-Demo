//
//  SideMenuVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 09/08/23.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}


class SideMenuVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var defaultHighlightedCell: Int = 0

    var delegate: SideMenuViewControllerDelegate?
    
    var menu: [SideMenuModel] = [
           SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "CoreData"),
           SideMenuModel(icon: UIImage(systemName: "music.note")!, title: "Music"),
           SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Movies"),
           SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "Books"),
           SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "About Us"),
           SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Privacy Policy"),
           SideMenuModel(icon: UIImage(systemName: "hand.thumbsup.fill")!, title: "Contact Us ")
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(SideMenuCellTableViewCell.nib, forCellReuseIdentifier: SideMenuCellTableViewCell.identifier)

    }

}



// MARK: - UITableViewDataSource

extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCellTableViewCell.identifier, for: indexPath) as? SideMenuCellTableViewCell else { fatalError("xib doesn't exist") }

        cell.imgMenuItem.image = self.menu[indexPath.row].icon
        cell.lblMenuText.text = self.menu[indexPath.row].title
        
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 || indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
