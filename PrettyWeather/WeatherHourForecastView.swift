//
//  WeatherHourForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 04/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import Cartography
import WeatherIconsKit

class WeatherHourForecastView: UIView {
    private var didSetupConstraints = false
    private let iconLabel = UILabel()
    private let hourLabel = UILabel()
    private let tempsLabel = UILabel()
    
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
private extension WeatherHourForecastView{
    func setup(){
        addSubview(iconLabel)
        addSubview(hourLabel)
        addSubview(tempsLabel)
    }
}

// MARK: Layout
private extension WeatherHourForecastView{
    func layoutView() {
        layout(iconLabel) { view in
            view.center == view.superview!.center
            view.height == 50
        }
        layout(hourLabel) { view in
            view.centerX == view.superview!.centerX
            view.top == view.superview!.top
        }
        layout(tempsLabel) { view in
            view.centerX == view.superview!.centerX
            view.bottom == view.superview!.bottom
        }
    }
}

// MARK: Style
private extension WeatherHourForecastView{
    func style(){
        iconLabel.textColor = UIColor.whiteColor()
        hourLabel.font = UIFont.latoFontOfSize(20)
        hourLabel.textColor = UIColor.whiteColor()
        tempsLabel.font = UIFont.latoFontOfSize(20)
        tempsLabel.textColor = UIColor.whiteColor()
    }
}


// MARK: Render
extension WeatherHourForecastView{
    func render(weatherCondition: WeatherCondition){
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        hourLabel.text = dateFormatter.stringFromDate(weatherCondition.time)
        iconLabel.attributedText = iconStringFromIcon(weatherCondition.icon!, 30)
        
        var usesMetric = false
        if let localeSystem = NSLocale.currentLocale().objectForKey(NSLocaleUsesMetricSystem) as? Bool {
            usesMetric = localeSystem
        }
        
        if usesMetric {
            tempsLabel.text = "\(weatherCondition.minTempCelsius.roundToInt())° \(weatherCondition.maxTempCelsius.roundToInt())°"
        } else {
            tempsLabel.text = "\(weatherCondition.minTempFahrenheit.roundToInt())° \(weatherCondition.maxTempFahrenheit.roundToInt())°"
        }
    }
}

