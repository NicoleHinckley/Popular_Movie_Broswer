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
   
    // MARK: -  Structs
    struct StorybordIdentifiers {
        static let toMovieDetailSegue = "toMovieDetail"
        static let movieCell = "MovieCell"
    }
    
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        TMDBEngine.shared.fetchGenres()
        fetchPopularMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StorybordIdentifiers.toMovieDetailSegue {
            guard let movie = sender as? Movie else { return } // TODO: - Show an error
            guard let movieDetailVC = segue.destination as? MovieDetailVC else { return }
            movieDetailVC.movie = movie
        }
    }
    
    // MARK: -  Functions
    func fetchPopularMovies(){
        TMDBEngine.shared.fetchPopularMovies { (movies) in
            self.movies = movies
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorybordIdentifiers.movieCell) as? MovieCell else { return UITableViewCell ()}
       
        let movie = movies[indexPath.row]
        cell.configureCell(with: movie)
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.performSegue(withIdentifier: StorybordIdentifiers.toMovieDetailSegue, sender: movie)
    }
}
