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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    

    // setting up movies cell content
    func setupMoviesCell(indexpath:IndexPath) {
        ServiceLayer.getMovies { (returnedMovies) in
           // checking for cached data first
            if defaults.value(forKey: returnedMovies[indexpath.row].poster_path ?? "" ) != nil {
                let movieImage = defaults.value(forKey: returnedMovies[indexpath.row].poster_path ?? "")
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data:movieImage as! Data)
                }
            }else {
                // getting data from past view
            guard let imagePath = returnedMovies[indexpath.row].poster_path else {return}
            guard let imageUrl = URL(string: imagePath) else {return}
                self.indicator.startAnimating() // staring loader
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                    guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {return}
                    if httpResponse.statusCode == 200 {
                        if error == nil {
                            guard let data = data else {return}
                            DispatchQueue.main.async {
                                self.movieImage.image = UIImage(data: data)
                                self.indicator.stopAnimating() // stop loader
                                self.indicator.isHidden = true // hide loader
                                let imageData = self.movieImage.image!.jpegData(compressionQuality: 1.0)
                                defaults.setValue(imageData, forKey: "\(imagePath)")
                            }
                            
                        }else {
                            print(error?.localizedDescription as Any)
                        }
                    }else {
                        print(error?.localizedDescription as Any)
                    }
                    
            }).resume()
            }
            DispatchQueue.main.async {
                self.movieTitle.text = returnedMovies[indexpath.row].title
                self.movieVoteRate.text = String(describing: returnedMovies[indexpath.row].vote_average!)
                self.movieReleaseDate.text = returnedMovies[indexpath.row].release_date
            }
        }
    }

}
