//
//  NetworkingEngine.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/27/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import Foundation

class NetworkingEngine {
    
    private init (){}
    static let shared = NetworkingEngine()
    
    func downloadPopularMoviesJSON<T : Decodable>(from url : URL, completion : @escaping (T, _ error : Error?) -> ()) {
 
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    fatalError("Error with network request")
                } else if let jsonData = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let model = try jsonDecoder.decode(T.self, from: jsonData)
                        completion(model, nil)
                        print(model)
                    } catch {
                      // TODO: - Present error
                    }
                }
            }
        }
        task.resume()
    }

}
