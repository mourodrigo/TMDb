//
//  Movie.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import Foundation

class Movie {
    let id: Int
    let title: String
    let backdropPath: String
    let overview: String
    let releaseDate: Date?
    let genreIds: [Int]
    
    init(id: Int, title: String, backdropPath: String, overview: String, releaseDate: Date?, genreIds: [Int]) {
        self.id = id
        self.title = title
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }

}
