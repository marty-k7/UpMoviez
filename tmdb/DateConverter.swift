//
//  File.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 02/06/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation
import SwiftDate

//naudojant static func
class Date {
    static func formatted(date: String) -> String? {
        let dt = date.toDate(DateFormat.ISO8601Format(.Date))
        let date = dt?.toString(DateFormat.Custom("MMM dd, YYYY"))
        return date
    }
}

//Sukuriant extension
extension String {
    func formattedDateString() -> String? {
        let dt = self.toDate(DateFormat.ISO8601Format(.Date))
        return dt?.toString(DateFormat.Custom("MMM dd, YYYY"))
    }
}