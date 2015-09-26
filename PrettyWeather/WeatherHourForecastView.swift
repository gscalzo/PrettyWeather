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
        constrain(iconLabel) { view in
            view.center == view.superview!.center
            view.height == 50
        }
        constrain(hourLabel) { view in
            view.centerX == view.superview!.centerX
            view.top == view.superview!.top
        }
        constrain(tempsLabel) { view in
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
    func render(){
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        hourLabel.text = dateFormatter.stringFromDate(NSDate())
        iconLabel.attributedText = WIKFontIcon.wiDaySunnyIconWithSize(30).attributedString()
        
        tempsLabel.text = "5° 8°"
    }
}
