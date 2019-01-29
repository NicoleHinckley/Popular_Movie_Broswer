//
//  NHImageView.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/28/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

// Custom class that is set on image views in the storyboard that will require a download.
// Uses image caching and indicator views.

class DownloadableImageView : UIImageView {
 
    var imageURL : String?
    var activityIndicator : UIActivityIndicatorView!
    
    func imageFromServerURL(_ URLString: String?, placeHolder: UIImage?) {
        // Exits out and uses placeholder if the url sent isn't valid.
        guard let urlString = URLString else {
            self.image = placeHolder
            return
        }
        
        // Sets up a URL to check later on to ensure the correct image is loaded in.
        self.imageURL = urlString
        self.image = nil
        
        // Checks the cache for the image before going into a download
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
                //If the urls are missmatched, immediately exit out. This will happen when cells are reused.
                if self.imageURL != url.absoluteString { return }
                
                if let error = error {
                    print("ERROR LOADING IMAGES FROM: " + error.localizedDescription)
                }
        
                //Setting up a variable that will eventually be either a placeholder or a downloaded image.
                var newImage = placeHolder
                
                //If the data is there, and the image can be created, set it to the above variable and cache it.
                if let data = data , let downloadedImage = UIImage(data : data){
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                       newImage = downloadedImage
                }
                
                //Get back to the main thread before updating the UI.
                DispatchQueue.main.async {
                    self.image = newImage
                    self.activityIndicator.stopAnimating()
                }
            }).resume()
        }
        
    }
}
