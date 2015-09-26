//
//  WeatherHourlyForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 03/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
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
private extension WeatherHourlyForecastView{
    func setup(){
    }
}

// MARK: Layout
private extension WeatherHourlyForecastView{
    func layoutView(){
        constrain(self) { view in
            view.height == 60
            return
        }
    }
}

// MARK: Style
private extension WeatherHourlyForecastView{
    func style(){
        backgroundColor = UIColor.greenColor()
    }
}