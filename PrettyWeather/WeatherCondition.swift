//
//  WeatherCondition.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 26/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation

enum IconType: String {
    case i01d = "01d.png"
    case i01n = "01n.png"
    case i02d = "02d.png"
    case i02n = "02n.png"
    case i03d = "03d.png"
    case i03n = "03n.png"
    case i04d = "04d.png"
    case i04n = "04n.png"
    case i09d = "09d.png"
    case i09n = "09n.png"
    case i10d = "10d.png"
    case i10n = "10n.png"
    case i11d = "11d.png"
    case i11n = "11n.png"
    case i13d = "13d.png"
    case i13n = "13n.png"
    case i50d = "50d.png"
    case i50n = "50n.png"
}

struct WeatherCondition {
    let cityName: String?
    let weather: String
    let icon: IconType
    let time: NSDate
    let maxTempKelvin: Float
    let minTempKelvin: Float

    var maxTempFahrenheit: Float {
        get {
            return maxTempCelsius * 9.0/5.0 + 32.0
        }
    }
    var minTempFahrenheit: Float {
        get {
            return minTempKelvin * 9.0/5.0 + 32.0
        }
    }
    
    var maxTempCelsius: Float {
        get {
            return maxTempKelvin - 273.15
        }
    }
    var minTempCelsius: Float {
        get {
            return minTempKelvin - 273.15
        }
    }
    
}