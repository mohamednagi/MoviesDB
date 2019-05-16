//
//  MoviesExtension.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/16/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

extension MoviesViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    // handling number of presented rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    // handling cell's height to be more comfort with it's content
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    // handling cell's contents depending on cell's setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setupMoviesCell(indexpath: indexPath)
        return cell
    }
    // handling selected cell with passing it's data to the next view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieInfoView") as? MovieInfoView else {return}
        destinationVC.clickedMovie = moviesList[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
