//
//  MaterialTextField.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 09/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = SHADOW_COLOR.CGColor
        layer.borderWidth = 1.0
    }
    
    //For placeholder
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    //For editable text
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}
