//
//  MovieDetailVC.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

class MovieDetailVC : UIViewController {
    
    // MARK: -  Outlets
    
    @IBOutlet weak var movieImage : UIImageView!
    @IBOutlet weak var movieDescription : UITextView!
    
    // MARK: -  Globals
    var movie : Movie!
    
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        self.title = movie.title
        self.movieDescription.text = movie.overview
    }
}

