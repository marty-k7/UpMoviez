//
//  MaterialNavBar.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 17/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit

class MaterialNavBar: UINavigationBar {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = SHADOW_COLOR.CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }

}
