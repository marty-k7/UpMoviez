//
//  DataService.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 12/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//


import UIKit

class DataService {
    static let instance = DataService()
    var watchlist  = [Movie]()
    
    func saveWatchlist() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(watchlist)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Identifiers.Watchlist.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadWatchlist() {
        if let movieData = NSUserDefaults.standardUserDefaults().objectForKey(Identifiers.Watchlist.rawValue) as? NSData {
            guard let moviesArray = NSKeyedUnarchiver.unarchiveObjectWithData(movieData) as? [Movie] else { return}
            watchlist = moviesArray
        }
    }
    
    func removeFromWatchlist(movie: Movie) {
        for mv in watchlist {
            if mv.movieID == movie.movieID {
                watchlist.removeAtIndex(watchlist.indexOf(mv)!)
            }
        }
        saveWatchlist()
    }
    
    func addToWatchlist(movie: Movie) {
        watchlist.append(movie)
        saveWatchlist()
        loadWatchlist()
    }
}
