//
//  PersonInfoVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 10/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage
import SwiftDate

class PersonInfoVc: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var placeOfBirthLbl: UILabel!
    @IBOutlet weak var birthAndDeathLbl: UILabel!
    @IBOutlet weak var biographyTxtView: UITextView!
    @IBOutlet weak var loadingView: UIView!

    var personID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.hidden  = false
        downloadPersonInfo(personID, completion: {
            self.loadingView.hidden = true
        })
    }
    
    func downloadPersonInfo(personID: Int, completion: () -> Void) {
        
        if let url = NSURL(string: "\(PERSON_URL_BASE)\(personID)?\(API_KEY)") {
                Alamofire.request(.GET, url).responseJSON { response in
                    guard let personInfo = Mapper<Person>().map(response.result.value) else {return}
                    self.nameLbl.text = personInfo.personName
                    self.placeOfBirthLbl.text = personInfo.placeOfBirth
                    self.biographyTxtView.text = personInfo.biography
                    
                    if let Bday = personInfo.birthday where Bday != "" {
                        let birth = Bday.formattedDateString()!
                        if let Dday = personInfo.deathday where Dday != "" {
                            let death = Date.formatted(Dday)!
                            self.birthAndDeathLbl.text = "\(birth) - \(death)"
                        } else {
                            self.birthAndDeathLbl.text = "\(birth)"
                        }
                    } else {
                        self.birthAndDeathLbl.text = "No info"
                    }
                    if let url = personInfo.profileImgUrl {
                        self.profileImg.af_setImageWithURL(url, placeholderImage: TMDB_LOGO_IMG)
                    } else {
                        self.profileImg.image = TMDB_LOGO_IMG
                    }
                    
                completion()
            }
        }
    }
}
