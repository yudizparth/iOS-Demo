//
//  WebSeries.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 20/07/23.
//

import Foundation

class Webseries {
    let seriesName : String
    var id : String
    let language : String
    let summary : String
    let status : String
    let genres : [String]
    let image : Poster?
    let netwrok : Netwrok?
    let runtime : Runtime?
    let premierDate : String
    let seasonNo : String
    let numberOfEpisode : String
    
    init(dict: NSDictionary) {
        self.seriesName = dict.getStringValue(key: "name")
        self.id = dict.getStringValue(key: "id")
        self.language = dict.getStringValue(key: "language")
        self.summary = dict.getStringValue(key: "summary")
        self.status = dict.getStringValue(key: "status")
        self.genres = dict.getStringArray(key: "genres")
        self.premierDate = dict.getStringValue(key: "airdate")
        self.seasonNo = dict.getStringValue(key: "season")
        self.numberOfEpisode = dict.getStringValue(key: "number")
        if let imgDict = dict["image"] as? NSDictionary {
            self.image = Poster(dict:imgDict)
        }else {
            self.image = nil
        }
        if let netwrokDict = dict["network"] as? NSDictionary {
            self.netwrok = Netwrok(dict:netwrokDict)
        }else {
            self.netwrok = nil
        }
        if let runtimeDic = dict["rating"] as? NSDictionary {
            self.runtime = Runtime(dict:runtimeDic)
        }else {
            self.runtime = nil
        }
    }
    
}

class Poster {
    let posterImage : String
    init(dict: NSDictionary){
        self.posterImage = dict.getStringValue(key: "medium")
    }
    var posterImageURL : URL? {
        return URL(string: posterImage)
    }
}

class Runtime {
    var averageRuntime : String
    init(dict: NSDictionary){
        self.averageRuntime = dict.getStringValue(key:"average")
        if (self.averageRuntime.isEmpty){
            self.averageRuntime  = "N/A"
        }
    }
}

class Netwrok {
    let netwrokName : String
    init(dict: NSDictionary){
        self.netwrokName = dict.getStringValue(key: "netwrokName")
    }
}
