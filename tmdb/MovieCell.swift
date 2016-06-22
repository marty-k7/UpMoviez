//
//  UpcomingMovieCell.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 05/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(movie: Movie) {
        
        if let url = movie.backdropUrl  {
            posterImg.af_setImageWithURL(url, placeholderImage: TMDB_LOGO_IMG)
        } else {
            posterImg.image = TMDB_LOGO_IMG
        }
        posterImg.contentMode = .ScaleAspectFill
        titleLbl.text = movie.title
        if let releaseDate = Date.formatted(movie.releaseDate) {
            self.releaseDateLbl.text = releaseDate
        } else {
            self.releaseDateLbl.text = "release date is unknown"
        }
    }
}
