//
//  Constants.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

class TMDBEngine {
    

    fileprivate let API_KEY = "21b84234aecaeadd5515637bc22d475e"
    fileprivate let URL_BASE = "https://api.themoviedb.org/3/movie/popular/"
    fileprivate let IMAGE_URL_BASE = "https://image.tmdb.org/t/p/original/"
    struct TMDBQueryKey {
        static let API_KEY = "api_key"
    }
    
    func fetchPopularMovies(completion : @escaping ([Movie]) -> ()){
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org" // TODO: - Refactor
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: TMDBQueryKey.API_KEY, value: API_KEY)
        ]
        guard let url = components.url else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                fatalError("Error with network request")
            } else if let jsonData = data {
                do {
                   let jsonDecoder = JSONDecoder()
                   let popularMoviesResult = try jsonDecoder.decode(PopularMoviesResult.self, from: jsonData)
                   completion(popularMoviesResult.results)
                
                } catch {
                    
                }
            }
            
            
        }
        task.resume()
    }
 
   static func fetchMoviePosterImage(posterPath : String ,completion : (UIImage) -> ()){
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org" // TODO: - Refactor
        components.path = "/t/p/original\(posterPath)"
     
        
        guard let url = components.url else { return }
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        completion( UIImage(data: data!)!)
    }
    
}
