//
//  TableViewDiffableVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 24/08/23.
//

struct UserModel : Hashable {
    var name : String  = ""
}



import UIKit

typealias UserDataSource = UITableViewDiffableDataSource<UserSection, UserModel>


class TableViewDiffableVC: UIViewController {
    
    var dataSource : UserDataSource!
    var arrUser = [UserModel]()
    
    @IBOutlet weak var tblView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        arrUser = getAllData()
        createSnapShot(user:arrUser)
    }

}

//MARK: - Methods
extension TableViewDiffableVC {
    
    func getAllData() -> [UserModel]{
        return  [
            UserModel(name :"Parth"),
            UserModel(name :"Hitesh"),
            UserModel(name :"BAMD"),
            UserModel(name :"YIUA"),
            UserModel(name :"APkAD"),
            UserModel(name :"DAJK"),
        ]
    }
    
    func configureData(){
        dataSource = UserDataSource(tableView: tblView) { tableView, indexPath, user -> UITableViewCell? in
               let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
               cell.textLabel?.text = user.name
               return cell
           }
    }
    
    func addData( name : String){
        arrUser.append(UserModel(name: name))
        createSnapShot(user:arrUser)
    }
    
    func createSnapShot(user : [UserModel]){
        var snapShot = NSDiffableDataSourceSnapshot<UserSection , UserModel>()
        snapShot.appendSections([.first])
        snapShot.appendItems(user)
        dataSource.apply(snapShot , animatingDifferences: true)
    }
    
    func deleteItem(at index: Int) {
        arrUser.remove(at: index)
        updateSnapshot()
    }
    
    func updateSnapshot() {
        var newSnapshot = NSDiffableDataSourceSnapshot<UserSection, UserModel>()
        newSnapshot.appendSections([.first])
        newSnapshot.appendItems(arrUser, toSection: .first)
        dataSource.apply(newSnapshot, animatingDifferences: true)
    }
    
    func updateItem(at index: Int, with newName: String) {
        arrUser[index].name = newName
        createSnapShot(user: arrUser)
    }
    
    func showAlertForRow(at indexPath: IndexPath) {
        let user = arrUser[indexPath.row] 
        
        let alert = UIAlertController.updateDataAlert(title: "Update", message: "Update Your Data!", value: user.name) { enteredText in
            if let text = enteredText {
                self.updateItem(at: indexPath.row, with: text)
            }
        }

        present(alert, animated: true, completion: nil)
    }

}


//MARK: - Actions
extension TableViewDiffableVC {
   
    @IBAction func appData(_ sender : UIButton){
        let alert = UIAlertController.addDataAlert(title: "Add Data", message: "Enter your name here") { enteredText in
            if let text = enteredText {
                self.addData(name: text)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapToback(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


extension TableViewDiffableVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            self?.deleteItem(at: indexPath.row)
            completion(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
