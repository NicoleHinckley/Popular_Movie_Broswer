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
    let posterPath : String?
    let backdropPath : String?
    let overview : String
    let voteAverage : Double
    let popularity : Double
    let genreIDs : [Int]
    let voteCount : Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case voteAverage = "vote_average"
        case popularity
        case genreIDs = "genre_ids"
        case voteCount = "vote_count"
    }
}

struct GenresResult : Codable {
    let genres :  [Genre]
}

struct Genre : Codable {
    let name : String
    let id : Int
}


