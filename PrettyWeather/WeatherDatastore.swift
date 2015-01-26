//
//  WeatherDatastore.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 26/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherDatastore {
    
    func updateForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
            return
            let url = "http://api.openweathermap.org/data/2.5/forecast"
            let params = ["lat":latitude, "lon":longitude]
            println(params)
            
            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    if(error != nil) {
                        println("Error: \(error)")
                        println(request)
                        println(response)
//                        self.loading.text = "Internet appears down!"
                    }
                    else {
                        println("Success: \(url)")
                        println(request)
                        var json = JSON(json!)
                        println(json)
//                        self.updateUISuccess(json)
                    }
            }
    }

}