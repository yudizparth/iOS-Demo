//
//  DatabaseHelper.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 21/08/23.
//

import Foundation
import CoreData
import UIKit


class DataBaseHelper {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieInfo")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        })
        return container
    }()
    
    static var sharedInstace = DataBaseHelper()
    let fetchRequest: NSFetchRequest<MovieInfo> = MovieInfo.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: MovieInfo.fetchRequest())

    func save(object : [String :Any]){
        let saveMovieData = NSEntityDescription.insertNewObject(forEntityName: "MovieInfo", into: persistentContainer.viewContext) as! MovieInfo
        saveMovieData.movieName = object["movieName"] as? String
        saveMovieData.movieGener = object["movieGener"] as? String
        saveMovieData.language = object["language"] as? String
        saveMovieData.moviePoster = object["moviePoster"] as? Data
        saveMovieData.id = UUID().uuidString
        do {
            try persistentContainer.viewContext.save()
        }catch {
            print("Data Not Save")
        }
    }
    
    func clearData(){
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieInfo")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try persistentContainer.viewContext.execute(deleteRequest)
                try persistentContainer.viewContext.save()
            } catch let error as NSError {
                print("Could not clear data. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchData() -> [MovieInfo]{
        do {
            let fetchedResults = try persistentContainer.viewContext.fetch(fetchRequest)
            for item in fetchedResults {
                if item.movieName != nil {
                }
            }
            return fetchedResults
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteData(index : Int ) -> [MovieInfo]{
        var movieInfo = fetchData()
        persistentContainer.viewContext.delete(movieInfo[index])
        movieInfo.remove(at: index)
        do {
            try persistentContainer.viewContext.save()
        }catch{
            print("Haveing issue During Delete Data ")
        }
        return movieInfo
    }
    
    func update(object : [String : Any] , i : Int){
        let movieInfo = fetchData()
        movieInfo[i].movieName = object["movieName"] as? String
        movieInfo[i].movieGener = object["movieGener"] as? String
        movieInfo[i].language = object["language"] as? String
        movieInfo[i].moviePoster = object["moviePoster"] as? Data
        do {
            try persistentContainer.viewContext.save()
        }
        catch{
            print("Haveing issue During Updating Data ")
        }
    }
    
}
