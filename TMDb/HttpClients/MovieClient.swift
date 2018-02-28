//
//  MovieClient.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//  Fetches all movies from :
//  https://developers.themoviedb.org/3/movies/

import SwiftyJSON
import Alamofire
import Foundation

class MovieClient {
    
    class func fetchUpcoming() {
        
        if let upcomingURL = URL.init(string: ConfigurationClient.sharedInstance.baseURLPath() + "movie/upcoming?" + ConfigurationClient.sharedInstance.apiKeyParameter() ) {
            print("fetching upcomingURL ", upcomingURL)

            Alamofire.request(upcomingURL).responseJSON { response in
                
                if response.response?.statusCode == 200, let value = response.result.value {
                    
                    var fetchedMovies = [Movie]()
                    let json = JSON(value)

                    if  let results = json.dictionaryValue["results"],
                        let moviesArray = results.array {
                                                
                        for movie in moviesArray {
                            
                            let newMovie = Movie(id: movie["id"].intValue,
                                                 title: movie["title"].stringValue,
                                                 backdropPath: movie["backdrop_path"].stringValue,
                                                 posterPath: movie["poster_path"].stringValue,
                                                 overview: movie["overview"].stringValue,
                                                 releaseDate: movie["release_date"].stringValue.toDate(),
                                                 genreIds: movie["genre_ids"].arrayValue.flatMap({ (json) -> Int in
                                                                                                    return json.intValue
                                                                                                 })
                            )
                            fetchedMovies.append(newMovie)
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name.init("didfetchMovies"), object: fetchedMovies)
                }
            }
        }
    
    }
    
}
