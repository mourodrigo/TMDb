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
    
    var lastFetchPage = 1
    var isWorking = false

    func fetchMoreUpcoming() {
        self.fetchUpcoming(on: lastFetchPage+1)
    }
    
    func fetchUpcoming(on page:Int = 1) {
        
        if let upcomingURL = URL.init(string:
                                        ConfigurationClient.sharedInstance.baseURLPath() +
                                        "movie/upcoming?" +
                                        ConfigurationClient.sharedInstance.apiKeyParameter()
                                        + "&page=\(page)") {
            
            print("fetching upcomingURL ", upcomingURL)

            isWorking = true
            
            Alamofire.request(upcomingURL).responseJSON { response in
                
                if response.response?.statusCode == 200, let value = response.result.value {
                    
                    var fetchedMovies = [Movie]()
                    let json = JSON(value)
                    
                    self.lastFetchPage = page
                    
                    if  let results = json.dictionaryValue["results"],
                        let moviesArray = results.array {
                                                
                        for movie in moviesArray {
                            let newMovie = Movie(json: movie)
                            fetchedMovies.append(newMovie)
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name.init("didfetchMovies"), object: fetchedMovies)
                }
                self.isWorking = false
            }
        }
    }
    
    func fetchSearch(having searchQuery:String, on page:Int = 1) {
        if let upcomingURL = URL.init(string:
            ConfigurationClient.sharedInstance.baseURLPath() +
                "search/movie?" +
                ConfigurationClient.sharedInstance.apiKeyParameter()
                + "&query=\(searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
                + "&page=\(page)") {
            
            print("fetching search ", upcomingURL)
            
            isWorking = true
            
            Alamofire.request(upcomingURL).responseJSON { response in
                
                if response.response?.statusCode == 200, let value = response.result.value {
                    
                    var fetchedMovies = [Movie]()
                    let json = JSON(value)
                    
                    self.lastFetchPage = page
                    
                    if  let results = json.dictionaryValue["results"],
                        let moviesArray = results.array {
                        
                        for movie in moviesArray {
                            let newMovie = Movie(json: movie)
                            fetchedMovies.append(newMovie)
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name.init("didfetchMovies"), object: fetchedMovies)
                }
                self.isWorking = false
            }
        }
    }
}
