//
//  Product.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 28/08/23.
//

import Foundation

class Product {
        let id: Int
        let title: String
        let price: Double
        let description: String
        let category: String
        let image: String
        let rating: Rating?

    init(dict : NSDictionary) {
            self.id = dict.getIntValue(key: "id")
            self.title = dict.getStringValue(key: "title")
            self.price = dict.getDoubleValue(key: "price")
            self.description = dict.getStringValue(key: "description")
            self.category = dict.getStringValue(key: "category")
            self.image = dict.getStringValue(key: "image")
            
            if let ratingDict = dict["rating"] as? NSDictionary {
                self.rating = Rating(dict: ratingDict)
            }else {
                self.rating = nil
            }
        }
    
        var productImage : URL? {
            return URL(string: image)
        }
}


// MARK: - Rating
class Rating {
    var rate: Double = 0
    var count: Int = 0

    init(dict : NSDictionary) {
        self.rate = dict.getDoubleValue(key: "rate")
        self.count = dict.getIntValue(key: "430")
    }
}
