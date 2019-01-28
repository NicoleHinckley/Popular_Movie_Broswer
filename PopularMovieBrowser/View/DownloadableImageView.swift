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
    var imageURL : String!
    
    func imageFromServerURL(_ URLString: String?, placeHolder: UIImage?) {
        
        guard let urlString = URLString else {
            self.image = placeHolder
            return
        }
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            
            return
        }
        
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        self.addSubview(activityView)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.startAnimating()
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                }
                if let error = error {
                    print("ERROR LOADING IMAGES FROM URL: " + error.localizedDescription)
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
            
                    if let data = data {
                        if self.imageURL == url.absoluteString {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            DispatchQueue.main.async {
                            self.image = downloadedImage
                            }
                        }
                    }
                }
            }).resume()
        }
        
    }
}