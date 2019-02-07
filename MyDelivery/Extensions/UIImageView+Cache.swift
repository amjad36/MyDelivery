//
//  UIImageView+Cache.swift
//  MyDelivery
//
//  Created by Amjad Khan on 07/02/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import UIKit

protocol Cachable {}

private  let imageCache = NSCache<NSString, UIImage>()

extension UIImageView: Cachable {}

extension Cachable where Self: UIImageView {
    
    typealias SuccessCompletion = (Bool) -> ()
    
    func loadImageUsingCacheWithURLString(_ urlString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            completion(true)
            return
        }
        
        self.image = placeHolder
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                }
            }).resume()
        }
    }
}
