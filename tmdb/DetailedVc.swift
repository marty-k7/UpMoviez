//
//  DetailedVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 05/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage

typealias HeartCallbackType = (movies: [Movie]) -> Void

class DetailedVc: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var taglineLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var realeaseDateLbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var starsLbl: UILabel!
    @IBOutlet weak var overwievFIeld: UITextView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var genre: String?
    var movie: Movie!
    var cast: [Cast]!
    var crew: [Crew]!
    var trailersNames = [String]()
    var trailersSources = [String]()
    var images = [Image]()
    var heartEmptyImg = UIImage(named: "heart-empty")
    var heartFullImg = UIImage(named: "heart-full")
    var rightBarBtnImg = UIImage()
    var movieIsInWatchlist = false
    var heartTapHandler: HeartCallbackType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfMovieIsInWatchlist()
        createRightBarBtn()
        
        loadingView.hidden = false
        downloadEverything {
            self.loadingView.hidden = true
        }
    }

    //MARK: Movie info downloads
    func downloadEverything(completion: () -> Void) {
        
        let group = dispatch_group_create()
        
        dispatch_group_enter(group)
        downloadMovieDetails { 
            dispatch_group_leave(group)
        }
        
        dispatch_group_enter(group)
        downloadCreditsInfo { 
            dispatch_group_leave(group)
        }
        
        dispatch_group_enter(group)
        downloadTrailersInfo { 
            dispatch_group_leave(group)
        }
        
        dispatch_group_enter(group)
        downloadImages { 
            dispatch_group_leave(group)
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), {
            completion()
        })
    }
    
    func downloadMovieDetails(completion: () -> Void) {
        self.backgroundImg.image = TMDB_LOGO_IMG
        
        if let url = NSURL(string: "\(URL_BASE)movie/\(movie.movieID)?\(API_KEY)") {
            Alamofire.request(.GET, url).responseJSON { response in
                guard let movieInfo = Mapper<Movie>().map(response.result.value) else {return}
                self.titleLbl.text = movieInfo.title
                self.realeaseDateLbl.text = movieInfo.releaseDate.formattedDateString()
                self.taglineLbl.text = movieInfo.tagline
                self.overwievFIeld.text = movieInfo.overview
                
                if let genres = movieInfo.genres where genres.count > 0 {
                    guard let gen = genres[0]["name"] as? String else {return}
                    self.genre = gen
                    if genres.count > 1 {
                        for x in 1 ..< genres.count {
                            guard let gen = genres[x]["name"] as? String else {return}
                            self.genre! += ", \(gen)"
                        }  
                    }
                    self.genreLbl.text = self.genre
                    
                } else {
                    self.genreLbl.text = "unknown"
                }

                if let url = movieInfo.backdropUrl {
                    self.backgroundImg.af_setImageWithURL(url, placeholderImage: TMDB_LOGO_IMG)
                } else if let url = movieInfo.posterUrl {
                    self.backgroundImg.af_setImageWithURL(url, placeholderImage: TMDB_LOGO_IMG)
                }
                
                completion()
            }
        } 
    }
    
    func downloadCreditsInfo(completion: () -> Void) {
        if let url = NSURL(string: "\(URL_BASE)movie/\(movie.movieID)/credits?\(API_KEY)") {
            Alamofire.request(.GET, url).responseJSON { response in
                guard let creditsInfo = Mapper<Credits>().map(response.result.value) else {return}
                
                self.cast = creditsInfo.cast
                self.crew = creditsInfo.crew
     
                guard let cast = creditsInfo.cast else {return}
                var stars = [String]()
                for info in cast {
                    stars.append(info.starName)
                }
                self.starsLbl.text = stars.joinWithSeparator(", ")
                guard let crew = creditsInfo.crew else {return}
                var directors = [String]()
                for info in crew {
                    if let director = info.crewMemberJob where director == "Director" {
                        directors.append(info.crewMemberName)
                    }
                }
                self.directorLbl.text = directors.joinWithSeparator(", ")
                
                completion()
            }
        }
    }
    func downloadTrailersInfo(completion: () -> Void) {
        if let url = NSURL(string: "\(URL_BASE)movie/\(movie.movieID)/trailers?\(API_KEY)") {
            Alamofire.request( .GET, url).responseJSON { response in
                guard let info = Mapper<Youtube>().map(response.result.value) else {return}
                for trailer in info.trailers {
                    self.trailersNames.append(trailer.trailerName)
                    self.trailersSources.append(trailer.trailerSource)
                }
                
                completion()
            }
        }
    }
    
    func downloadImages(completion: () -> Void) {
        if let url = NSURL(string: "\(URL_BASE)movie/\(movie.movieID)/images?\(API_KEY)") {
            Alamofire.request( .GET, url).responseJSON { response in
                guard let backdropsInfo = Mapper<Backdrops>().map(response.result.value) else {return}
                self.images = backdropsInfo.backdrops
                
                completion()
            }
        }
    }
    //MARK: Segue & View Controller handlers
    @IBAction func showFullCrewVc(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier(SEGUE_CREW_INFO, sender: self)
    }
    
    @IBAction func imageTapped(sender: AnyObject) {
        if self.images.count > 0 {
            performSegueWithIdentifier(SEGUE_IMAGES_VC, sender: self)
        } else {
            self.showErrorAlert("Sorry", msg: "This movie has no photos at the time")
        }
    }
    
    @IBAction func trailersBtnTapped(sender: AnyObject) {
        if self.trailersSources.count > 0 {
            self.performSegueWithIdentifier(SEGUE_TRAILERS_LIST, sender: self)
        } else {
            self.showErrorAlert("We're sorry", msg: "This movie has no trailers at the time")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_CREW_INFO {
            
            guard let crewVc = segue.destinationViewController as? FullCrewVc else {return}
            crewVc.cast = self.cast
            crewVc.crew = self.crew
            
        }  else if segue.identifier == SEGUE_TRAILERS_LIST{
            
            guard let trailerVc = segue.destinationViewController as? TrailersVc else {return}
            trailerVc.trailers = trailersSources
            trailerVc.trailersNames = trailersNames
            
        } else if segue.identifier == SEGUE_IMAGES_VC {
            
            guard let imgVc = segue.destinationViewController as? ImagesVc else {return}
            imgVc.images = images
        }
    }
    //MARK: Watchlist 
    func createRightBarBtn() {
        
        if movieIsInWatchlist == false {
            rightBarBtnImg = heartEmptyImg!
        } else {
            rightBarBtnImg = heartFullImg!
        }
        
        let button = UIButton(type: .Custom)
        button.setImage(rightBarBtnImg, forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(DetailedVc.addToWatchListTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame=CGRectMake(0, 0, 45, 45)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func checkIfMovieIsInWatchlist()  {
        let watchlist = DataService.instance.watchlist
        for mv in watchlist {
            if mv.movieID == movie.movieID {
                self.movieIsInWatchlist = true
            }
        }
    }
    
    @IBAction func addToWatchListTapped(sender: AnyObject) {
        checkIfMovieIsInWatchlist()
        if movieIsInWatchlist == false {
            DataService.instance.addToWatchlist(movie)
            movieIsInWatchlist = true
            
        } else {
            DataService.instance.removeFromWatchlist(movie)
            movieIsInWatchlist = false
            
        }
        createRightBarBtn()
    }
    
    // suveikia, kai paspaudžiam back mygtuką.
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            heartTapHandler?(movies: DataService.instance.watchlist)
        }
    }
}
