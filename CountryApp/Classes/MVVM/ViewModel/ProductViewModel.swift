//
//  ProductViewModel.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 28/08/23.
//

import Foundation


final class ProductViewModel{
    var productList : [Product] = []
    var eventHandler : ( (_ evnt : Event) -> Void)?
    
    func fetchData(){
        APIManager.shareInstance.getProductData { result in
            self.eventHandler?(.isLoading)
            switch result {
            case .success(let json):
                self.eventHandler?(.stopLoading)
                if let arr = (json as? [NSDictionary]){
                    for dict in arr {
                        let data = Product(dict: dict)
                        self.productList.append(data)
                    }
                }
                self.eventHandler?(.dataLoaded)
                break
            case .failure(let error):
                print("Error is",error)
                self.eventHandler?(.error(error))
                break
            }
        }
    }

}


extension ProductViewModel {
    
    enum Event {
        case isLoading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
    
}
