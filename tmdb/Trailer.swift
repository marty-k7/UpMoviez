//
//  Trailer.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 11/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation
import ObjectMapper

class Youtube: Mappable {
    
    var trailers: [Trailer]!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        trailers <- map[Identifiers.Youtube.rawValue]
    }
}

class Trailer: Mappable {
    
    var trailerName: String!
    var trailerSource: String!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        trailerName     <- map[Identifiers.Name.rawValue]
        trailerSource   <- map[Identifiers.Source.rawValue]
    }
}