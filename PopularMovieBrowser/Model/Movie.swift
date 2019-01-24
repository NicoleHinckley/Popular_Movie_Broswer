//
//  Movie.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import Foundation


struct PopularMoviesResult : Codable {
    let results : [Movie]
    let page : Int 
}
struct Movie : Codable {
    let title : String
    let id : Int
    let poster_path : String
    let overview : String
}


