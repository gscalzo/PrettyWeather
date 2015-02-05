//
//  CurrentWeatherView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 03/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import Cartography
import LatoFont
import WeatherIconsKit

class CurrentWeatherView: UIView {
    private var didSetupConstraints = false
    private let cityLbl = UILabel()
    private let maxTempLbl = UILabel()
    private let minTempLbl = UILabel()
    private let iconLbl = UILabel()
    private let weatherLbl = UILabel()
    private let currentTempLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if didSetupConstraints {
            super.updateConstraints()
            return
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }
}

// MARK: Setup
private extension CurrentWeatherView{
    func setup(){
        addSubview(cityLbl)
        addSubview(currentTempLbl)
        addSubview(maxTempLbl)
        addSubview(minTempLbl)
        addSubview(iconLbl)
        addSubview(weatherLbl)
    }
}

// MARK: Layout
private extension CurrentWeatherView{
    func layoutView(){
        layout(self) { view in
            view.height == 160
            return
        }
        layout(iconLbl) { view in
            view.top == view.superview!.top
            view.left == view.superview!.left + 20
            view.width == 30
            view.width == view.height
        }
        layout(weatherLbl, iconLbl) { view, view2 in
            view.top == view2.top
            view.left == view2.right + 10
            view.height == view2.height
            view.width == 200
        }
        
        layout(currentTempLbl, iconLbl) { view, view2 in
            view.top == view2.bottom
            view.left == view2.left
        }
        
        layout(currentTempLbl, minTempLbl) { view, view2 in
            view.bottom == view2.top
            view.left == view2.left
        }
        
        layout(minTempLbl) { view in
            view.bottom == view.superview!.bottom
            view.height == 30
        }
        
        layout(maxTempLbl, minTempLbl) { view, view2 in
            view.top == view2.top
            view.height == view2.height
            view.left == view2.right + 10
        }
        layout(cityLbl) { view in
            view.bottom == view.superview!.bottom
            view.right == view.superview!.right - 10
            view.height == 30
            view.width == 200
        }
    }
}

// MARK: Style
private extension CurrentWeatherView{
    func style(){
        iconLbl.textColor = UIColor.whiteColor()
        weatherLbl.font = UIFont.latoLightFontOfSize(20)
        weatherLbl.textColor = UIColor.whiteColor()
        
        currentTempLbl.font = UIFont.latoLightFontOfSize(96)
        currentTempLbl.textColor = UIColor.whiteColor()
        
        maxTempLbl.font = UIFont.latoLightFontOfSize(18)
        maxTempLbl.textColor = UIColor.whiteColor()
        
        minTempLbl.font = UIFont.latoLightFontOfSize(18)
        minTempLbl.textColor = UIColor.whiteColor()
        
        cityLbl.font = UIFont.latoLightFontOfSize(18)
        cityLbl.textColor = UIColor.whiteColor()
        cityLbl.textAlignment = .Right
    }
}

// MARK: Render
extension CurrentWeatherView{
    func render(weatherCondition: WeatherCondition){
        iconLbl.attributedText = iconStringFromIcon(weatherCondition.icon!, 20)
        weatherLbl.text = weatherCondition.weather
        
        var usesMetric = false
        if let localeSystem = NSLocale.currentLocale().objectForKey(NSLocaleUsesMetricSystem) as? Bool {
            usesMetric = localeSystem
        }
        
        if usesMetric {
            minTempLbl.text = "\(weatherCondition.minTempCelsius.roundToInt())°"
            maxTempLbl.text = "\(weatherCondition.maxTempCelsius.roundToInt())°"
            currentTempLbl.text = "\(weatherCondition.tempCelsius.roundToInt())°"
        } else {
            minTempLbl.text = "\(weatherCondition.minTempFahrenheit.roundToInt())°"
            maxTempLbl.text = "\(weatherCondition.maxTempFahrenheit.roundToInt())°"
            currentTempLbl.text = "\(weatherCondition.tempFahrenheit.roundToInt())°"
        }
        
        cityLbl.text = weatherCondition.cityName ?? ""
    }
}
