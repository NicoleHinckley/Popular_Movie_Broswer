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
    }
}