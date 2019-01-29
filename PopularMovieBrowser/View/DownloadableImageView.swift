//
//  NHImageView.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/28/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class DownloadableImageView : UIImageView {
 
    var imageURL : String?
    var activityIndicator : UIActivityIndicatorView!
    
    func imageFromServerURL(_ URLString: String?, placeHolder: UIImage?) {
        
        guard let urlString = URLString else {
            self.image = placeHolder
            return
        }
        self.imageURL = urlString
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            
            return
        }
        
        if self.activityIndicator == nil {
            self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            activityIndicator.center = self.center
            self.addSubview(activityIndicator)
            activityIndicator.hidesWhenStopped = true
        
        }
    
        activityIndicator.startAnimating()
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if self.imageURL != url.absoluteString { return }
                
                if let error = error {
                    print("ERROR LOADING IMAGES FROM: " + error.localizedDescription)
                }
            
                
                var newImage = placeHolder
                
                if let data = data , let downloadedImage = UIImage(data : data){
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                       newImage = downloadedImage
                }
                
                DispatchQueue.main.async {
                    self.image = newImage
                    self.activityIndicator.stopAnimating()
                }
            }).resume()
        }
        
    }
}
