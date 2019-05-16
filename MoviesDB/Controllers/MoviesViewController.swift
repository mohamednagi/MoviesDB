//
//  MoviesViewController.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    // creating movies array with tableView loader
    var moviesList:[MovieModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting navigation name
        navigationItem.title = "Top Rated Movies"
        
        ServiceLayer.getMovies { (returnedMoviesList) in
            // filling movies list with returned movies from API (escaping closure)
            self.moviesList = returnedMoviesList
        }
        // setting delegate and dataSource to MoviesViewController
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
}
