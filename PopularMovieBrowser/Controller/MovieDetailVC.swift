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
    
    // MARK: -  Globals
    var movie : Movie!
    
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        self.title = movie.title
    }
}

