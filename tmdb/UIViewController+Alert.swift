//
//  UIViewController+Alert.swift
//  tmdb
//
//  Created by Martynas Klastaitis on 2016-06-06.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit

extension UIViewController {
   
    func showErrorAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: handler)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}
