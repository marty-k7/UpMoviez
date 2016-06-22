//
//  MaterialImage.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 16/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit

class MaterialImage: UIImageView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 4.0
//        FIXME: Kai padarai clips to bounds nerodo shadows. priešingu atveju nesuapvalina kampų
//        clipsToBounds = true
        layer.borderColor = SHADOW_COLOR.CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
}
