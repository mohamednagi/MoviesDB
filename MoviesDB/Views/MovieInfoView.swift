//
//  MovieInfoView.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class MovieInfoView: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieID: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieVoteCount: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieVoteAverage: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var clickedMovie: MovieModel! = nil //object represent the selected movie from past view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // filling data from past view
        movieID.text = String(describing: clickedMovie.id!)
        movieOverView.text = clickedMovie.overview
        movieTitle.text = clickedMovie.title
        moviePopularity.text = String(describing: clickedMovie.popularity!)
        movieVoteCount.text = String(describing: clickedMovie.vote_count!)
        movieReleaseDate.text = clickedMovie.release_date
        movieVoteAverage.text = String(describing: clickedMovie.vote_average!)
        
        // checking fot cached data first
        if defaults.value(forKey: clickedMovie.poster_path ?? "") != nil {
            let imageData = defaults.value(forKey: clickedMovie.poster_path ?? "")
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: imageData as! Data)
            }
        }else {
            // get the image from past view
        guard let imageUrl = URL(string: clickedMovie.poster_path!) else {return}
            indicator.startAnimating() // start loading 
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {return}
            if httpResponse.statusCode == 200 {
                if error == nil {
                    guard let data = data else {return}
                    DispatchQueue.main.async {
                        self.movieImage.image = UIImage(data:data)
                        self.indicator.stopAnimating() // stop loader
                        self.indicator.isHidden = true // hide loader
                    }
                }else {
                    print(error?.localizedDescription as Any)
                }
            }else {
                print(error?.localizedDescription as Any)
            }
            }.resume()
        }
    }
}
