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
    
    func retrieveCurrentWeatherAtLat(lat: CLLocationDegrees, lon: CLLocationDegrees,
        block: (weatherConditions: WeatherCondition) -> Void) {
            let url = "http://api.openweathermap.org/data/2.5/weather"
            let params = ["lat":lat, "lon":lon]
            println(params)
            
            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    if(error != nil && json != nil) {
                        println("Error: \(error)")
                        println(request)
                        println(response)
//                        self.loading.text = "Internet appears down!"
                    }
                    else {
                        println("Success: \(url)")
                        println(json)
                        var json = JSON(json!)
                        println(json)
//                        self.updateUISuccess(json)
                    }
            }
    }

    func retrieveHourlyForecastAtLat(lat: CLLocationDegrees,
        lon: CLLocationDegrees,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
            let url = "http://api.openweathermap.org/data/2.5/forecast"
            let params = ["lat":lat, "lon":lon]
            println(params)
            
            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    if(error != nil && json != nil) {
                        println("Error: \(error)")
                        println(request)
                        println(response)
                        //                        self.loading.text = "Internet appears down!"
                    }
                    else {
                        println("Success: \(url)")
                        println(json)
                        var json = JSON(json!)
                        println(json)
                        //                        self.updateUISuccess(json)
                    }
            }
    }
    
    func retrieveDailyForecastAtLat(lat: Double,
        lon: Double,
        dayCnt: Int,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
            let url = "http://api.openweathermap.org/data/2.5/forecast/daily"
            let params = ["lat":lat, "lon":lon, "cnt":Double(dayCnt)]
            println(params)
            
            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    if(error != nil && json != nil) {
                        println("Error: \(error)")
                        println(request)
                        println(response)
                        //                        self.loading.text = "Internet appears down!"
                    }
                    else {
                        println("Success: \(url)")
                        println(json)
                        var json = JSON(json!)
                        println(json)
                        //                        self.updateUISuccess(json)
                    }
            }
    }
    
}