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
    
    
    struct StorybordSegue {
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
        if segue.identifier == StorybordSegue.toMovieDetail {
            guard let movie = sender as? Movie else { return }
            guard let movieDetailVC = segue.destination as? MovieDetailVC else { return }
            movieDetailVC.movie = movie
        }
    }
    
    // MARK: -  Functions
    func fetchPopularMovies(){
        let movie1 = Movie(title: "A Star is Born")
        let movie2 = Movie(title: "Lion King")
        let movie3 = Movie(title: "Harry Potter")
        
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        
        tableView.reloadData()
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
        self.performSegue(withIdentifier: StorybordSegue.toMovieDetail, sender: movie)
    }
}