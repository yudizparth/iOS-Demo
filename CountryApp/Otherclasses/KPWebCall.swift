//
//  KPWebCall.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 29/06/23.
//

import Foundation
import Alamofire
import UIKit

enum APIError : Error {
    case custom(message : String)
    case invaliData
    case invalidResponse
    case invalidStatusCode
}

typealias WSBlock = (_ json: Any?, _ flag: Int) -> ()
typealias WSProgress = (Progress) -> ()?
typealias WSFileBlock = (_ path: String?, _ error: Error?) -> ()
typealias Handler = (Swift.Result<Any?,APIError>) -> Void

class APIManager{
    static let shareInstance = APIManager()
    
    func getCountryData(completionHandler : @escaping Handler){
        
        let header : HTTPHeaders = [.contentType("application/json"),]
        AF.request(countryList,method:.get,encoding: JSONEncoding.default,headers: header).response { response in
            
            guard let responseCode = response.response?.statusCode , 200...299 ~= responseCode else {
                return completionHandler(.failure(.invalidStatusCode))
            }

            switch  response.result {
            case .success(let data): do {
                let json = try JSONSerialization.jsonObject(with: data! ,options: [])
                completionHandler(.success(json))
            }catch {
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
        }
        
    }
    
    
    func searchCountry( searchText : String,completionHandler : @escaping Handler){
        let header : HTTPHeaders = [.contentType("application/json"),]
        var request: DataRequest?
        request?.cancel()
        request =  AF.request(searchCountryURL + "\(searchText)",method:.get ,encoding: JSONEncoding.default,headers: header).response { response in
            switch  response.result {
            case .success(let data): do {
                let  json = try JSONSerialization.jsonObject(with: data! ,options: [])
                if response.response?.statusCode == 200 {
                    completionHandler(.success(json))
                }else {
                    if let jsonDict = json as? [String: Any], let message = jsonDict["message"] as? String {
                            completionHandler(.success(message))
                    }
                }
                
            }catch {
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
        }
        
    }
    
    func searchWebSeries( searchText : String,completionHandler : @escaping Handler){
        
        let header : HTTPHeaders = [.contentType("application/json"),]
            
        AF.request(searchWebSeriesURL+"?q=\(searchText)",method:.get,encoding: JSONEncoding.default,headers: header).response { response in
            print(searchWebSeriesURL+"?q=\(searchText)")
            switch  response.result {
            case .success(let data): do {
                let  json = try JSONSerialization.jsonObject(with: data! ,options: [])
         
                if response.response?.statusCode == 200 {
                    completionHandler(.success(json))
                }else {
                    completionHandler(.failure(.custom(message: "Please check your Netwrok Connectivty ")))
                }
                
            }catch {
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
        }
        
    }
    
    func getEpisodes( id : String,completionHandler : @escaping Handler){
        let header : HTTPHeaders = [.contentType("application/json"),]
        AF.request(episodeURL+"/\(id)"+"/episodes",method:.get,encoding: JSONEncoding.default,headers: header).response { response in
            print("\(episodeURL+"/\(id)"+"/episodes")")
            switch  response.result {
            case .success(let data): do {
                let  json = try JSONSerialization.jsonObject(with: data! ,options: [])
         
                if response.response?.statusCode == 200 {
                    completionHandler(.success(json))
                }else {
                    completionHandler(.failure(.custom(message: "Please check your Netwrok Connectivty ")))
                }
                
            }catch {
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
        }
        
    }
    
    
    func getProductData(completionHandler : @escaping Handler){
        
        let header : HTTPHeaders = [.contentType("application/json"),]
        AF.request(productURL,method:.get,encoding: JSONEncoding.default).response { response in
            
            guard let responseCode = response.response?.statusCode , 200...299 ~= responseCode else {
                return completionHandler(.failure(.invalidStatusCode))
            }
            
            switch  response.result {
            case .success(let data): do {
                let json = try JSONSerialization.jsonObject(with: data! ,options: [])
                completionHandler(.success(json))
            }catch {
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again ")))
            }
        }
        
    }
}
