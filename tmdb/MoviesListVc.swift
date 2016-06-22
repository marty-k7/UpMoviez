//
//  ViewController.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 05/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


class MoviesListVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    var moviesArray = [Movie]()
    var movie: Movie!
    var moviesListIdentifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadingView.hidden = false
        downloadMoviesInfo(moviesListIdentifier) {
            self.loadingView.hidden = true
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    //MARK: UITableView delegate & data source methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath)
        if let cell = cell as? MovieCell {
            let movie = moviesArray[indexPath.row]
            cell.configureCell(movie)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        movie = moviesArray[indexPath.row]
        performSegueWithIdentifier(SEGUE_DETAILED_VIEW, sender: self)
    }
    
    //MARK: Download info, segue  handler & watchlist handler
    func downloadMoviesInfo(identifier: String, completion: () -> Void ) {
        if identifier == Identifiers.Watchlist.rawValue {
            moviesArray = DataService.instance.watchlist
            if moviesArray.count == 0 {
                showErrorAlert("Your Watchlist is empty!", msg: "Find movies you like and click heart button to add them", handler: { (UIAlertAction) in
                    self.performSegueWithIdentifier(SEGUE_UNWIND_MAIN_VC, sender: self)
                })
            }
        } else if identifier != Identifiers.Watchlist.rawValue {
            let url = NSURL(string: "\(URL_BASE)\(identifier)\(API_KEY)")
            Alamofire.request(.GET, url!).responseJSON { response in
                guard let moviesInfo = Mapper<Results>().map(response.result.value) else {return}
                self.moviesArray = moviesInfo.results
                self.tableView.reloadData()
                
                if self.moviesArray.count == 0 {
                    self.showErrorAlert("Ooops", msg: "There is no movies with this title. Try write another title", handler: { (UIAlertAction) in
                        self.performSegueWithIdentifier(SEGUE_UNWIND_MAIN_VC, sender: self)
                    })
                }
            }
        }
        completion()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == SEGUE_DETAILED_VIEW {
            guard let detailVc = segue.destinationViewController as? DetailedVc else {return}
            detailVc.movie = movie
            detailVc.heartTapHandler = { (movies: [Movie]) in
                if self.moviesListIdentifier == Identifiers.Watchlist.rawValue {
                    self.moviesArray = movies
                    if self.moviesArray.count == 0 {
                        self.showErrorAlert("Your Watchlist is empty!", msg: "Find movies you like and click heart button to add them", handler: { (UIAlertAction) in
                            self.performSegueWithIdentifier(SEGUE_UNWIND_MAIN_VC, sender: self)
                        })
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func userDidUnclickedHeart(moviesArray: [Movie]) {
        if moviesListIdentifier == Identifiers.Watchlist.rawValue {
            self.moviesArray = moviesArray
        }
    }
}

