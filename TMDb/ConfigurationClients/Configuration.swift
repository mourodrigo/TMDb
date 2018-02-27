//
//  Configuration.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//
//  Used to fetch basic app configuration and routes described on
//  https://developers.themoviedb.org/3/configuration/get-api-configuration

let baseUrl = "https://api.themoviedb.org/3/"
let apiKey = "1f54bd990f1cdfb230adb312546d765d"

class Configuration {

    private init() {
        print("Authorization init")
    }
    
    static let sharedInstance: Configuration = {
        let instance = Configuration()
        return instance
    }()
    
}
