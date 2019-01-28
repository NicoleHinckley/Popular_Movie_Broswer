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
    
    var movieGenres : [Genre] = []
    
    
    // TODO: - Rename these
     let TMBD_API_KEY = "21b84234aecaeadd5515637bc22d475e"
     let API_SCHEME = "https"
     let MOVIE_API_HOST = "api.themoviedb.org"
     let MOVIE_IMAGE_API_HOST = "image.tmdb.org"
     let POPULAR_MOVIE_PATH = "/3/movie/popular"
     let MOVIE_IMAGE_PATH = "/t/p/w300"
     let MOVIE_GENRE_PATH = "/3/genre/movie/list"
    
    struct TMDBQueryKey {
        static let API_KEY = "api_key"
        static let PAGE = "page"
    }
    
    func popularMoviesURL(forPage page : Int) -> URL? {
        let url = NetworkingEngine.shared.createURL(scheme: API_SCHEME, host: MOVIE_API_HOST, path: POPULAR_MOVIE_PATH,
                queryItems: [ URLQueryItem(name: TMDBQueryKey.API_KEY, value: TMBD_API_KEY),
                              URLQueryItem(name: TMDBQueryKey.PAGE, value: String(page))
            ])
        return url
    }
    
    lazy var genresURL : URL? = {
        let url = NetworkingEngine.shared.createURL(scheme: API_SCHEME, host: MOVIE_API_HOST, path: MOVIE_GENRE_PATH, queryItems: [URLQueryItem(name: TMDBQueryKey.API_KEY, value: TMBD_API_KEY)])
        return url
    }()
    
    
    func movieBackdropImageURL(for movie : Movie) -> URL? {
        guard let path = movie.backdropPath else { return nil }
        guard let url = NetworkingEngine.shared.createURL(scheme: API_SCHEME, host: MOVIE_IMAGE_API_HOST, path: MOVIE_IMAGE_PATH + path, queryItems: []) else { return nil }
        return url
    }
    
    func fetchPopularMovies(onPage page: Int, completion : @escaping (PopularMoviesResult) -> ()){
        guard let url = popularMoviesURL(forPage: page) else { return }
        NetworkingEngine.shared.downloadJSON(from: url) { (popularMovies : PopularMoviesResult?, error) in
            if let err = error {
                print("ERROR " + err.localizedDescription)
                return
            }
           
            if let popularMovies = popularMovies {
                completion(popularMovies)
          }
        }
    }
    
    func fetchGenres(){
        guard let url = genresURL else { return }
        NetworkingEngine.shared.downloadJSON(from: url) { (genresResult : GenresResult?, error) in
            if let err = error {
                print("ERROR " + err.localizedDescription)
                return
            }
            if genresResult == nil {
                //Handle this
            } else {
                self.movieGenres = genresResult!.genres
            }
       
        }
    }
}
