//
//  WeatherHourlyForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 26/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import Cartography

class WeatherHourlyForecastView: UIView {
    private var didSetupConstraints = false
    
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
private extension WeatherHourlyForecastView{
    func setup(){
    }
}

// MARK: Layout
extension WeatherHourlyForecastView{
    
    override func updateConstraints() {
        if didSetupConstraints == false {
            super.updateConstraints()
        }
        layout(self) { view in
            view.height == 80
            return
        }
        super.updateConstraints()
        didSetupConstraints = true
    }
}

// MARK: Style
private extension WeatherHourlyForecastView{
    func style(){
        backgroundColor = UIColor.blueColor()
    }
}
