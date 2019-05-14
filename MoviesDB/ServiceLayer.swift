//
//  ServiceLayer.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import UIKit

class ServiceLayer: NSObject {
    
    
    class func getMovies(completionHandler: @escaping (_ array:[MovieModel]) -> ()) {
        
        var oneMovie = [MovieModel]()
        
        let topRatedMoviesUrlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=dbbd139cd20c1999dffaa2eed72d5a86"
        guard let topRatedMoviesUrl = URL(string: topRatedMoviesUrlString) else {return}
        
        URLSession.shared.dataTask(with: topRatedMoviesUrl) { (data, _, error) in
            if error == nil {
                
                guard let data = data else {return}
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {return}
                    guard let movies = json["results"] as? [[String:Any]] else {return}
                    for movie in movies {
                        guard let title = movie["title"] as? String else {return}
                        guard let vote_average = movie["vote_average"] as? Double else {return}
                        guard let poster_path = movie["poster_path"] as? String else {return}
                        guard let release_date = movie["release_date"] as? String else {return}
                        guard let id = movie["id"] as? Int else {return}
                        guard let popularity = movie["popularity"] as? Double else {return}
                        guard let overview = movie["overview"] as? String else {return}
                        guard let vote_count = movie["vote_count"] as? Int else {return}
                        
                        let object = MovieModel(title: title, vote_average: vote_average, poster_path: "http://image.tmdb.org/t/p/w780/\(poster_path)", release_date: release_date,id: id, overview: overview, popularity: popularity, vote_count: vote_count)
                        oneMovie.append(object)
                    }
                    completionHandler(oneMovie)
                }catch {
                    print(error.localizedDescription)
                }
                
            }else {
                print(error?.localizedDescription as Any)
            }
        }.resume()
        
    }
    

}
