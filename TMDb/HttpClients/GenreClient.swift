//
//  GenreClient.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//
// Fetch genres list as described in:
// https://developers.themoviedb.org/3/genres/get-movie-list

import SwiftyJSON
import Alamofire

import Foundation

class GenreClient {
    
    var genresList = [Int:String]()
    
    private init() {
        print("Authorization init")
    }
    
    static let sharedInstance: GenreClient = {
        let instance = GenreClient()
        return instance
    }()
    
    func apiUrl() -> URL {
        return URL.init(string: ConfigurationClient.sharedInstance.baseURLPath() + "genre/movie/list?" + ConfigurationClient.sharedInstance.apiKeyParameter() )!
    }
    
    func fetchAll() {
        print("fetching GenreClient ", apiUrl())
        Alamofire.request(apiUrl()).responseJSON { response in
            
            if response.response?.statusCode == 200, let value = response.result.value {
                let json = JSON(value)
                if let genresArray = json["genres"].array {
                    for genre in genresArray {
                        self.genresList[genre["id"].intValue] = genre["name"].stringValue
                    }
                }
            
            }
            NotificationCenter.default.post(name: NSNotification.Name.init("didfetchGenres"), object: self.genresList)
        }
    }
    
}
