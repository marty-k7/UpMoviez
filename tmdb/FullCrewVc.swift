//
//  FullCrewVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 09/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import AlamofireImage

class FullCrewVc: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
 
    var sectionTitles = ["Full Cast", "Full Crew"]
    var cast: [Cast]!
    var crew: [Crew]!
    var movieId: Int!
    var personID: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: UITableView delegate & data source methods

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles [section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return cast.count
        } else {
            return crew.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sectionName = sectionTitles[indexPath.section]
        let cell = tableView.dequeueReusableCellWithIdentifier("CharacterCell", forIndexPath: indexPath) as! CharacterCell
        if sectionName == "Full Cast" {
            cell.castMember = cast[indexPath.row]
        } else {
            cell.crewMember = crew[indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sectionName = sectionTitles[indexPath.section]
        if sectionName == "Full Cast" {
            personID = cast[indexPath.row].starId
            performSegueWithIdentifier(SEGUE_PERSON_INFO, sender: self)
        } else {
            personID = crew[indexPath.row].crewMemberId
            performSegueWithIdentifier(SEGUE_PERSON_INFO, sender: self)
        }    
    }
    //MARK: Segue handler
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_PERSON_INFO {
            guard let personVc = segue.destinationViewController as? PersonInfoVc else {return}
            personVc.personID = personID
        }
    }
    
}
