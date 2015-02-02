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
        block: (weatherCondition: WeatherCondition) -> Void) {
            let url = "http://api.openweathermap.org/data/2.5/weather"
            let params = ["lat":lat, "lon":lon]

            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    println(response)
                    if(error != nil || json == nil) {
                        println("Error: \(error)")
                    } else {
                        let json = JSON(json!)
                        block(weatherCondition: self.createWeatherConditionFronJson(json))
                    }
            }
    }
    
    func retrieveHourlyForecastAtLat(lat: CLLocationDegrees,
        lon: CLLocationDegrees,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
            let url = "http://api.openweathermap.org/data/2.5/forecast"
            let params = ["lat":lat, "lon":lon]
            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    if(error != nil || json == nil) {
                        println("Error: \(error)")
                    }
                    else {
                        let json = JSON(json!)
                        let list: Array<JSON> = json["list"].arrayValue
                        
                        let weatherConditions: Array<WeatherCondition> = list.map() {
                            return self.createWeatherConditionFronJson($0)
                        }
                        block(weatherConditions: weatherConditions)
                    }
            }
    }
    
    func retrieveDailyForecastAtLat(lat: Double,
        lon: Double,
        dayCnt: Int,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
            let url = "http://api.openweathermap.org/data/2.5/forecast/daily"
            let params = ["lat":lat, "lon":lon, "cnt":Double(dayCnt+1)]
            Alamofire.request(.GET, url, parameters: params)
                .responseJSON { (request, response, json, error) in
                    if(error != nil || json == nil) {
                        println("Error: \(error)")
                    } else {
                        var json = JSON(json!)
                        let list: Array<JSON> = json["list"].arrayValue
                        NSLog("\(list)")
                        NSLog("flush")
                        let weatherConditions: Array<WeatherCondition> = list.map() {
                            return self.createDayForecastFronJson($0)
                        }
                        let count = weatherConditions.count
                        let daysWithoutToday = Array(weatherConditions[1..<count])
                        block(weatherConditions: daysWithoutToday)
                    }
            }
    }
    
}

private extension WeatherDatastore {
    func createWeatherConditionFronJson(json: JSON) -> WeatherCondition{
        let name = json["name"].string
        let weather = json["weather"][0]["main"].stringValue
        let icon = json["weather"][0]["icon"].stringValue
        let dt = json["dt"].doubleValue
        let time = NSDate(timeIntervalSince1970: dt)
        let tempKelvin = json["main"]["temp"].doubleValue
        let maxTempKelvin = json["main"]["temp_max"].doubleValue
        let minTempKelvin = json["main"]["temp_min"].doubleValue
        
        return WeatherCondition(
            cityName: name,
            weather: weather,
            icon: IconType(rawValue: icon),
            time: time,
            tempKelvin: tempKelvin,
            maxTempKelvin: maxTempKelvin,
            minTempKelvin: minTempKelvin)
    }
    func createDayForecastFronJson(json: JSON) -> WeatherCondition{
        let name = ""
        let weather = json["weather"][0]["main"].stringValue
        let icon = json["weather"][0]["icon"].stringValue
        let dt = json["dt"].doubleValue
        let time = NSDate(timeIntervalSince1970: dt)
        let tempKelvin = json["temp"]["day"].doubleValue
        let maxTempKelvin = json["temp"]["max"].doubleValue
        let minTempKelvin = json["temp"]["min"].doubleValue
        
        return WeatherCondition(
            cityName: name,
            weather: weather,
            icon: IconType(rawValue: icon),
            time: time,
            tempKelvin: tempKelvin,
            maxTempKelvin: maxTempKelvin,
            minTempKelvin: minTempKelvin)
    }
}
