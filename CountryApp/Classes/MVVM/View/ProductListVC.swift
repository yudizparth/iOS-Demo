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
                print("isLoading..........")
                break
            case .stopLoading :
                print("stopLoading..........")
                break
            case .dataLoaded :
                print("dataLoaded..........")
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform  = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
        //MARK: - Animation usiug SpringWithDamping .... Springy Wave Behave to View Animate
//        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5) {
//            cell.alpha = 1.0
//            cell.layer.transform = CATransform3DIdentity
//        }
    }
}
