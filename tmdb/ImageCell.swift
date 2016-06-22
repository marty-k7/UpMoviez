//
//  ImageCell.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 10/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
  
    func configureCell(img: Image) {
        movieImg.image = nil
        if let url = img.imageUrl {
            movieImg.af_setImageWithURL(url)
        }
    }
}
