//
//  Backdrops.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 10/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation
import ObjectMapper

class Backdrops: Mappable {
    
    var backdrops: [Image]!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        backdrops <- map[Identifiers.BackdropsArray.rawValue]
    }
}

class Image: Mappable {
    
    var imagePath: String!
    var imageUrl: NSURL? {
        return NSURL(string: "\(IMG_URL_BASE)\(imagePath)")
    }
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        imagePath <- map[Identifiers.ImagePath.rawValue]
    }
}
