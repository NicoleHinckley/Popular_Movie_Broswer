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
    var popularMoviesResult : PopularMoviesResult?
    var currentPage = 1
    var isCurrentlyLoadingNewMovies : Bool = false
    
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
            guard let movie = sender as? Movie else {
             self.alert(message: "Cannot show details for this movie")
                return
            }
            guard let movieDetailVC = segue.destination as? MovieDetailVC else { return }
            movieDetailVC.movie = movie
        }
    }
    
    // MARK: -  Functions
    func fetchPopularMovies(){
        isCurrentlyLoadingNewMovies = true
        
        TMDBEngine.shared.fetchPopularMovies(onPage: currentPage) { (popularMoviesResult) in
            self.isCurrentlyLoadingNewMovies = false
            if self.currentPage == 1 {
            self.popularMoviesResult = popularMoviesResult
            self.movies = popularMoviesResult.results // TODO: - Rename to movies
            self.tableView.reloadData()
            } else {
              
               self.movies.append(contentsOf: popularMoviesResult.results)
                self.tableView.reloadData()
            }
        }
    }
    
    func loadMoreMovies(){
        if isCurrentlyLoadingNewMovies { return }
        currentPage = currentPage + 1
         fetchPopularMovies()
        print("Should load some more movies!")
        
    }
}

    // MARK: -  TableView Delegate and DataSource
extension FeedVC : UITableViewDataSource, UITableViewDelegate {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorybordIdentifiers.movieCell, for: indexPath) as? MovieCell else { return UITableViewCell()}

        if let moviesResult = popularMoviesResult {
            
            if indexPath.row == movies.count - 1 {
            if moviesResult.total_results > movies.count {
                loadMoreMovies()
           }
          }
        }
        let movie = movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let movie = movies[indexPath.row]
        self.performSegue(withIdentifier: StorybordIdentifiers.toMovieDetailSegue, sender: movie)
    }
}
