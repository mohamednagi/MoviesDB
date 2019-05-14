//
//  MovieModel.swift
//  MoviesDB
//
//  Created by Mohamed Nagi on 5/14/19.
//  Copyright © 2019 Mohamed Nagi. All rights reserved.
//

import Foundation

struct MovieModel {
    let title:String?
    let vote_average:Double?
    let poster_path:String?
    let release_date:String?
    let id:Int?
    let overview:String?
    let popularity:Double?
    let vote_count:Int?
    
    init(title:String,vote_average:Double,poster_path:String,release_date:String,id:Int,overview:String,popularity:Double,vote_count:Int) {
        self.title = title
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.release_date = release_date
        self.id = id
        self.overview = overview
        self.popularity = popularity
        self.vote_count = vote_count
    }
}
