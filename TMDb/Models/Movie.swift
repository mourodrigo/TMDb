//
//  Movie.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    let id: Int
    let title: String
    let backdropPath: String
    let posterPath: String
    let overview: String
    let releaseDate: Date?
    let genreIds: [Int]
    
    init(id: Int, title: String, backdropPath: String, posterPath: String, overview: String, releaseDate: Date?, genreIds: [Int]) {
        self.id = id
        self.title = title
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
    
    convenience init(json: JSON) {
       self.init(id: json["id"].intValue,
                 title: json["title"].stringValue,
                 backdropPath: json["backdrop_path"].stringValue,
                 posterPath: json["poster_path"].stringValue,
                 overview: json["overview"].stringValue,
                 releaseDate: json["release_date"].stringValue.toDate(),
                 genreIds: json["genre_ids"].arrayValue.flatMap({ (idsArr) -> Int in
                    return idsArr.intValue
                 })
        )
    }

}
