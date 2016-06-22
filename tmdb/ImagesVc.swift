//
//  ImagesCollectionVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 10/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//

import UIKit

class ImagesVc: UICollectionViewController {
    
    var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.reloadData()
    }
    
    //MARK: UICollectionView delegate & data source methods
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let img = images[indexPath.row]
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as? ImageCell {
            cell.configureCell(img)
            return cell
        }
        
        return UICollectionViewCell()
    }
}


