//
//  ViewController.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    // MARK: -  Outlets
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: -  Globals
    var movies = [Movie]()
   
    struct StorybordIdentifiers {
        static let toMovieDetail = "toMovieDetail"
    }
    
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPopularMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StorybordIdentifiers.toMovieDetail {
            guard let movie = sender as? Movie else { return }
            guard let movieDetailVC = segue.destination as? MovieDetailVC else { return }
            movieDetailVC.movie = movie
        }
    }
    
    // MARK: -  Functions
    func fetchPopularMovies(){
        
        TMDBEngine.shared.fetchPopularMovies { (movies) in
            self.movies = movies
            for movie in movies {
                print( movie.title + " rating is " + String(movie.vote_average))
            }
                self.tableView.reloadData()
        }
    }
}

    // MARK: -  TableView Delegate and DataSource
extension FeedVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell else { return UITableViewCell ()}
       
        let movie = movies[indexPath.row]
        cell.configureCell(withMovie: movie)
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.performSegue(withIdentifier: StorybordIdentifiers.toMovieDetail, sender: movie)
    }
}
