//
//  ProductListVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 28/08/23.
//

import UIKit

class ProductListVC: UIViewController {
    
    private var viewModel = ProductViewModel()
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugration()
    }
}


extension ProductListVC {
    func confugration(){
        tableView.register(ProductCellTableViewCell.nib, forCellReuseIdentifier: ProductCellTableViewCell.productCell)
        initViewModel()
        observer()
    }
    func initViewModel(){
        viewModel.fetchData()
    }
    func observer(){
        viewModel.eventHandler = { [weak self] event in
            guard self != nil else  {return }
            switch event {
            case .isLoading :
                print("isLoading")
                break
            case .stopLoading :
                print("stopLoading")
                break
            case .dataLoaded :
                print("dataLoaded")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            case .error(let error) :
                print("Error is\(String(describing: error))")
                break
            }
        }
    }
}

extension ProductListVC {
    @IBAction func tapToBack(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProductListVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCellTableViewCell.productCell, for: indexPath) as? ProductCellTableViewCell else {return UITableViewCell() }
        cell.product = viewModel.productList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
