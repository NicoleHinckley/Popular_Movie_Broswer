//
//  MovieCell.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

class MovieCell : UITableViewCell {
    
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieImage : UIImageView!
    
    func configureCell(withMovie movie : Movie) {
      movieTitle.text = movie.title
      
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org" // TODO: - Refactor
        components.path = "/t/p/original\(movie.backdrop_path)"
        
        
        guard let url = components.url else { return }
    
        movieImage.imageFromServerURL(url.absoluteString, placeHolder: nil)
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
    //    self.movieImage.addSubview(activityIndicator)
    }
}
