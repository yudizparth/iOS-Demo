//
//  MovieInfo+CoreDataProperties.swift
//  
//
//  Created by Yudiz Solutions Pvt. Ltd. on 21/08/23.
//
//

import Foundation
import CoreData


extension MovieInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieInfo> {
        return NSFetchRequest<MovieInfo>(entityName: "MovieInfo")
    }

    @NSManaged public var movieName: String?
    @NSManaged public var language: String?
    @NSManaged public var movieGener: String?
    @NSManaged public var id: String?
    @NSManaged public var moviePoster: Data?

}
