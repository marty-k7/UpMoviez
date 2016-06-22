//
//  TrailersVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 11/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class TrailersVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var trailers = [String]()
    var trailersNames = [String]()
    var movieId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
    }
  
    //MARK: UITableView delegate & data source methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trailers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellName  = trailersNames[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TrailerCell", forIndexPath: indexPath)
        cell.textLabel?.text = cellName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let trailerId = trailers[indexPath.row]
        self.performSegueWithIdentifier(SEGUE_VIDEO_PLAYER, sender: trailerId)
    }
    
    //MARK: Segue handler
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_VIDEO_PLAYER {
            if let trailerVc = segue.destinationViewController as? VideoPlayerVc {
                trailerVc.videoId = sender as! String
            }
        }
    }
}
