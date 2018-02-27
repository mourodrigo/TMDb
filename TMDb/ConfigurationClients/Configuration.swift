//
//  Configuration.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//
//  Used to fetch basic app configuration and routes described on
//  https://developers.themoviedb.org/3/configuration/get-api-configuration

import SwiftyJSON
import Alamofire

let baseUrl = "https://api.themoviedb.org/3/"
let apiKey = "1f54bd990f1cdfb230adb312546d765d"

class Configuration {
    
    var data:JSON?
    
    private init() {
        print("Authorization init")
    }
    
    static let sharedInstance: Configuration = {
        let instance = Configuration()
        return instance
    }()
    
    func apiKeyParameter() -> String {
        return "api_key=" + apiKey
    }
    
    func configurationUrl() -> URL {
        return URL.init(string: baseUrl + "configuration?" + apiKeyParameter() )!
    }
    
    func fetchConfiguration() {
        print("fetching configuration ", configurationUrl())
        Alamofire.request(configurationUrl()).responseJSON { response in
            
            if response.response?.statusCode == 200, let value = response.result.value {
                self.data = JSON(value)
                print("CONFIGURATION ", self.data)
            }
            NotificationCenter.default.post(name: NSNotification.Name.init("didfetchConfiguration"), object: self.data)
        }
    }
    
}
