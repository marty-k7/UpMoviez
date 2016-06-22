//
//  Credit.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 08/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation
import ObjectMapper

class Credits: Mappable {
    
    var cast: [Cast]!
    var crew: [Crew]!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        cast <- map[Identifiers.Cast.rawValue]
        crew <- map[Identifiers.Crew.rawValue]
    }
}

class Cast: Mappable {
    
    var character: String!
    var starName: String!
    var starId: Int!
    var starProfileImgPath: String!
    var starProfileImgUrl: NSURL? {
        return NSURL(string: "\(IMG_URL_BASE)\(starProfileImgPath)")
    }
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        character           <- map[Identifiers.Character.rawValue]
        starName            <- map[Identifiers.Name.rawValue]
        starId              <- map[Identifiers.Id.rawValue]
        starProfileImgPath  <- map[Identifiers.ProfilePath.rawValue]
    }
}

class Crew: Mappable {
    
    var crewMemberJob: String!
    var crewMemberName: String!
    var crewMemberId: Int!
    var crewMemberImgPath: String!
    var crewMemberImgUrl: NSURL? {
        return NSURL(string: "\(IMG_URL_BASE)\(crewMemberImgPath)")
    }
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        crewMemberJob       <- map[Identifiers.Job.rawValue]
        crewMemberName      <- map[Identifiers.Name.rawValue]
        crewMemberId        <- map[Identifiers.Id.rawValue]
        crewMemberImgPath   <- map[Identifiers.ProfilePath.rawValue]
    }
}