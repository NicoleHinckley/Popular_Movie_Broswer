//
//  Constants.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

class TMDBEngine {
    
    private init(){}
    static let shared = TMDBEngine()
    
    fileprivate let API_KEY = "21b84234aecaeadd5515637bc22d475e"
    fileprivate let API_SCHEME = "https"
    fileprivate let API_HOST = "https://api.themoviedb.org"
    fileprivate let POPULAR_MOVIE_BASE = "/3/movie/popular"
 
    struct TMDBQueryKey {
        static let API_KEY = "api_key"
    }
    
    func fetchPopularMovies(completion : @escaping ([Movie]) -> ()){
        
        var components = URLComponents()
        components.scheme = API_SCHEME
        components.host = API_HOST
        components.path = POPULAR_MOVIE_BASE
        components.queryItems = [
            URLQueryItem(name: TMDBQueryKey.API_KEY, value: API_KEY)
        ]
        
        guard let url = components.url else { return }
    
        NetworkingEngine.shared.downloadPopularMoviesJSON(from: url) { (popularMovies : PopularMoviesResult, error) in
            guard error == nil else { return }
            completion(popularMovies.results)
        }
      
        
    }
}
