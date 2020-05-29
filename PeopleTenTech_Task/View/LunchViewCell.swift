//
//  LunchViewCell.swift
//  PeopleTenTech_Task
//
//  Created by Raghuram on 29/05/20.
//  Copyright © 2020 Raghuram. All rights reserved.
//

import Foundation
import UIKit

var imageCache: NSCache<AnyObject,AnyObject> = NSCache()

class LunchViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurentName: UILabel!
    @IBOutlet weak var dispImg: UIImageView!
    @IBOutlet weak var category: UILabel!
    
    
    
    func configCell(model: Restaurents){
        
        restaurentName.text = model.name
        category.text = model.category
        downloadImage(withUrlString: model.backgroundImageURL!)
        
    }
    
    
    
    
    
    
    
}

extension LunchViewCell {
    
    
    func downloadImage(withUrlString urlString: String) {
        
        let url = URL(string: urlString)!
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            
            self.dispImg.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                self.dispImg.image = imageToCache
                imageCache.setObject(imageToCache!, forKey: url.absoluteString as AnyObject)
            }
        }.resume()
        
    }
    
    
}
