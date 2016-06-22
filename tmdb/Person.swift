//
//  Person.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 10/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation
import ObjectMapper


class Person: Mappable {
    
    var personName: String!
    var biography: String!
    var profileImgPath: String!
    var profileImgUrl: NSURL? {
        return NSURL(string: "\(IMG_URL_BASE)\(profileImgPath)")
    }
    var birthday: String!
    var deathday: String!
    var placeOfBirth: String!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        personName      <- map[Identifiers.Name.rawValue]
        biography       <- map[Identifiers.Biography.rawValue]
        profileImgPath  <- map[Identifiers.ProfilePath.rawValue]
        birthday        <- map[Identifiers.Birthday.rawValue]
        deathday        <- map[Identifiers.Deathday.rawValue]
        placeOfBirth    <- map[Identifiers.PlaceOfBirth.rawValue]
    } 
}