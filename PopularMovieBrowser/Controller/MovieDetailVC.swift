//
//  MovieDetailVC.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/23/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

class MovieDetailVC : UIViewController {
    
    // MARK: -  Outlets
    @IBOutlet weak var movieImage : DownloadableImageView!
    @IBOutlet weak var movieDescription : UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    // MARK: -  Globals
    var movie : Movie!
    
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        configureView(with: movie)
    }
    
    func configureView(with movie : Movie) {
        self.title = movie.title
        self.movieDescription.text = movie.overview
        
        // TODO: -  Clean this up
        let genres = TMDBEngine.shared.movieGenres
        genreLabel.text = "Genre : N/A"
        
        guard let movieGenreID =  movie.genreIDs.first else { return }
        let genre = genres.filter {
            $0.id == movieGenreID
        }
        genreLabel.text = "Genre : \(genre.first?.name ?? "N/A")"
        ratingLabel.text = "Rating: \(String(movie.voteAverage))"
        voteCountLabel.text = "Vote count: \(String(movie.voteCount))"
        
        guard let url = TMDBEngine.shared.movieBackdropImageURL(for: movie) else { return }
        movieImage.imageFromServerURL(url.absoluteString, placeHolder: #imageLiteral(resourceName: "defaultMovieImage"))
    }
}

