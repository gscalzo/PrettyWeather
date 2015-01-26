//
//  WeatherForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 25/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import Cartography

class WeatherForecastView: UIView {
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
private extension WeatherForecastView{
    func setup(){
    }
}

// MARK: Layout
extension WeatherForecastView{
    
    override func updateConstraints() {
        if didSetupConstraints == false {
            super.updateConstraints()
        }
        layout(self) { view in
            view.width == view.superview!.width - 40
            view.height == 500
            return
        }
        super.updateConstraints()
        didSetupConstraints = true
    }
}

// MARK: Style
private extension WeatherForecastView{
    func style(){
        backgroundColor = UIColor.blueColor()
        
    backgroundColor = UIColor.redColor()
    }
}
