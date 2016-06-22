//
//  CharacterCell.swift
//  tmdb
//
//  Created by Martynas Klastaitis on 2016-06-06.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import Alamofire

class CharacterCell: UITableViewCell {
    
    var castMember: Cast! {
        didSet {
            textLabel?.text = castMember.starName
            detailTextLabel?.text = castMember.character
            
            guard let url = castMember.starProfileImgUrl else {
                imageView?.image = TMDB_LOGO_IMG
                return
            }
            
            loadRoundedImageFromURL(url)
        }
    }
    
    var crewMember: Crew! {
        didSet {
            textLabel?.text = crewMember.crewMemberName
            detailTextLabel?.text = crewMember.crewMemberJob
            
            guard let url = crewMember.crewMemberImgUrl else {
                imageView?.image = TMDB_LOGO_IMG
                return
            }
            
            loadRoundedImageFromURL(url)
        }
    }
    
    private func loadRoundedImageFromURL(url: NSURL) {
        Alamofire.request(.GET, url).responseImage { response in
            if let image = response.result.value {
                self.imageView?.image = image.af_imageWithRoundedCornerRadius(10)
            }
            
            self.setNeedsLayout()
        }
    }
}
