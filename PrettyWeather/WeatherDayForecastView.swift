//
//  WeatherDayForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 27/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import Cartography
import WeatherIconsKit

class WeatherDayForecastView: UIView {
    private var didSetupConstraints = false
    private let iconLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Setup
private extension WeatherDayForecastView{
    func setup(){
        addSubview(iconLabel)
    }
}

// MARK: Layout
extension WeatherDayForecastView{
    override func updateConstraints() {
        if didSetupConstraints == false {
            super.updateConstraints()
        }
        layout(iconLabel) { view in
            view.center == view.superview!.center
            return
        }
        super.updateConstraints()
        didSetupConstraints = true
    }
}

// MARK: Style
private extension WeatherDayForecastView{
    func style(){
        backgroundColor = UIColor.yellowColor()
        iconLabel.attributedText = WIKFontIcon.wiDayCloudyGustsIconWithSize(30).attributedString()
    }
}
