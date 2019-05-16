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
    
    
    
    var clickedMovie: MovieModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        movieID.text = String(describing: clickedMovie.id!)
        movieOverView.text = clickedMovie.overview
        movieTitle.text = clickedMovie.title
        moviePopularity.text = String(describing: clickedMovie.popularity!)
        movieVoteCount.text = String(describing: clickedMovie.vote_count!)
        movieReleaseDate.text = clickedMovie.release_date
        movieVoteAverage.text = String(describing: clickedMovie.vote_average!)
        
        if UserDefaults.standard.value(forKey: clickedMovie.poster_path ?? "") != nil {
            let imageData = UserDefaults.standard.value(forKey: clickedMovie.poster_path ?? "")
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: imageData as! Data)
            }
        }else {
        
        guard let imageUrl = URL(string: clickedMovie.poster_path!) else {return}
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            if error == nil {
                guard let data = data else {return}
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data:data)
                }
            }else {
                print(error?.localizedDescription as Any)
            }
            }.resume()
        }
    }
    
    
}
