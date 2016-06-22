//
//  Movie.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 05/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire

class Movie:  NSObject, NSCoding,  Mappable  {
    
    var title: String!
    var overview: String!
    var releaseDate: String!
    var posterPath: String!
    var posterUrl: NSURL? {
        return NSURL(string: "\(IMG_URL_BASE)\(posterPath)")
    }
    var movieID: Int!
    var genreName: String!
    var tagline: String!
    var backdropPath: String!
    var backdropUrl: NSURL? {
        return NSURL(string: "\(IMG_URL_BASE)\(backdropPath)")
    }
    var genres: [AnyObject]?

    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        title           <- map[Identifiers.Title.rawValue]
        overview        <- map[Identifiers.Overview.rawValue]
        releaseDate     <- map[Identifiers.ReleaseDate.rawValue]
        posterPath      <- map[Identifiers.Posterpath.rawValue]
        movieID         <- map[Identifiers.Id.rawValue]
        genreName       <- map[Identifiers.GenreName.rawValue]
        tagline         <- map[Identifiers.Tagline.rawValue]
        backdropPath    <- map[Identifiers.BackdropPath.rawValue]
        genres          <- map[Identifiers.Genres.rawValue]
    }
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey(Identifiers.Title.rawValue) as? String
        self.overview = aDecoder.decodeObjectForKey(Identifiers.Overview.rawValue) as? String
        self.releaseDate = aDecoder.decodeObjectForKey(Identifiers.ReleaseDate.rawValue) as? String
        self.posterPath = aDecoder.decodeObjectForKey(Identifiers.Posterpath.rawValue) as? String
        self.movieID = aDecoder.decodeObjectForKey(Identifiers.Id.rawValue) as? Int
        self.backdropPath = aDecoder.decodeObjectForKey(Identifiers.BackdropPath.rawValue) as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: Identifiers.Title.rawValue)
        aCoder.encodeObject(self.overview, forKey: Identifiers.Overview.rawValue)
        aCoder.encodeObject(self.releaseDate, forKey: Identifiers.ReleaseDate.rawValue)
        aCoder.encodeObject(self.posterPath, forKey: Identifiers.Posterpath.rawValue)
        aCoder.encodeObject(self.movieID, forKey: Identifiers.Id.rawValue)
        aCoder.encodeObject(self.backdropPath, forKey: Identifiers.BackdropPath.rawValue)
    }
}

class Results: Mappable {
    var results: [Movie]!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        results <- map[Identifiers.Results.rawValue]
    }
}
