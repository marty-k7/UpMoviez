//
//  Constants.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 05/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import Foundation

//MARK: URLs
let URL_BASE = "https://api.themoviedb.org/3/"
let API_KEY = "api_key=58635f34dd137097eb5c8bac9233d05c"
let IMG_URL_BASE = "http://image.tmdb.org/t/p/w300"
let PERSON_URL_BASE = "http://api.themoviedb.org/3/person/"


//MARK: Segue  identifiers
let SEGUE_MOVIES_LIST_VC = "MoviesList"
let SEGUE_DETAILED_VIEW = "DetailedView"
let SEGUE_CREW_INFO = "FullCrewInfo"
let SEGUE_PERSON_INFO = "PersonInfo"
let SEGUE_IMAGES_VC = "ImagesVc"
let SEGUE_TRAILERS_LIST = "TrailersList"
let SEGUE_VIDEO_PLAYER = "VideoPlayer"
let SEGUE_UNWIND_MAIN_VC = "unwindToMainVC"

//MARK: Identifiers
enum Identifiers: String {
    
    case Title = "title"
    case BackdropPath  = "backdrop_path"
    case ImdbId = "imdb_id"
    case Overview = "overview"
    case ProductionCompanies = "production_companies"
    case Tagline = "tagline"
    case Posterpath = "poster_path"
    case GenreName = "genres.0.name" // .0. mappinimo pode taip paimam array rakta
    case ReleaseDate = "release_date"
    case Runtime = "runtime"
    case Language = "spoken_languages.0.name"
    case Results = "results"
    case Id = "id"
    case Genres = "genres"
    case Cast = "cast"
    case Character = "character"
    case Name = "name"
    case Crew = "crew"
    case Job = "job"
    case Credits = "credits"
    case ProfilePath = "profile_path"
    case Biography = "biography"
    case PlaceOfBirth = "place_of_birth"
    case Birthday = "birthday"
    case Deathday = "deathday"
    case BackdropsArray = "backdrops"
    case ImagePath = "file_path"
    case Youtube = "youtube"
    case Source = "source"
    case AddedToWatchlist = "AddedToWatchlist"
    case Watchlist = "watchlist"
}

//MARK: Images
let TMDB_LOGO = "tmdb-logo"
let TMDB_LOGO_IMG = UIImage(named: TMDB_LOGO)

//MARK: Colors
let SHADOW_COLOR = UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.1)
let DARK_ORANGE = UIColor(red: 255.0/255.0, green: 87.0/255.0, blue: 34.0/255.0, alpha: 1)



