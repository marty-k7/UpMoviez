//
//  MainVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 08/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit

class MainVc: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    var moviesListIdentifier: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.loadWatchlist()
       
    }
    
    @IBAction func upcmonigMoviesTapped(sender: AnyObject) {
        self.moviesListIdentifier = "movie/upcoming?"
        performSegueWithIdentifier(SEGUE_MOVIES_LIST_VC, sender: self)
    }
  
    @IBAction func popularMoviesTapped(sender: AnyObject) {
        self.moviesListIdentifier = "movie/popular?"
        performSegueWithIdentifier(SEGUE_MOVIES_LIST_VC, sender: self)
    }
    
    @IBAction func nowPlayingTapped(sender: AnyObject) {
        self.moviesListIdentifier = "movie/now_playing?"
        performSegueWithIdentifier(SEGUE_MOVIES_LIST_VC, sender: self)
    }
    @IBAction func topRatedTapped(sender: AnyObject) {
        self.moviesListIdentifier = "movie/top_rated?"
        performSegueWithIdentifier(SEGUE_MOVIES_LIST_VC, sender: self)
    }
    
    @IBAction func myWatchlistTapped(sender: AnyObject) {
        self.moviesListIdentifier = Identifiers.Watchlist.rawValue
        performSegueWithIdentifier(SEGUE_MOVIES_LIST_VC, sender: self)
    }
   
    @IBAction func searchTapped(sender: AnyObject) {
        let enteredText = searchField.text
        let cleanText = enteredText?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if cleanText!.isEmpty {
            self.showErrorAlert("Searchfield is empty!", msg: "Please write something in")
            
        } else {
            guard let searchText = cleanText else { return }
            guard let escapedQueryText = searchText.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()) else { return }
            let escapedText = "search/movie?query=\(escapedQueryText)&"
            self.moviesListIdentifier = escapedText
            performSegueWithIdentifier(SEGUE_MOVIES_LIST_VC, sender: self)
            
        }
        self.searchField.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_MOVIES_LIST_VC {
            guard let moviesListVc = segue.destinationViewController as? MoviesListVc else {return}
            moviesListVc.moviesListIdentifier = moviesListIdentifier
        }
    }

    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) {}
}
