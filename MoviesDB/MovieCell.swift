//
//  MovieCell.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieVoteRate: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!

    
    func setupMoviesCell(indexpath:IndexPath) {
        ServiceLayer.getMovies { (returnedMovies) in
            guard let imagePath = returnedMovies[indexpath.row].poster_path else {return}
            guard let imageUrl = URL(string: imagePath) else {return}
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, _, error) in
                    if error == nil {
                        guard let data = data else {return}
                            DispatchQueue.main.async {
                                self.movieImage.image = UIImage(data: data)
                            }
                        
                    }else {
                        print(error?.localizedDescription as Any)
                    }
            }).resume()
            DispatchQueue.main.async {
                self.movieTitle.text = returnedMovies[indexpath.row].title
                self.movieVoteRate.text = String(describing: returnedMovies[indexpath.row].vote_average!)
                self.movieReleaseDate.text = returnedMovies[indexpath.row].release_date
            }
        }
    }

}
