//
//  WeatherResumeView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 25/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import UIKit
import Cartography

class WeatherResumeView: UIView {
    private var didSetupConstraints = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
//        layoutView()
        style()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if didSetupConstraints == false {
            super.updateConstraints()
        }

        layout(self) { view in
            view.width == 120
            view.height == 130
            return
        }
        super.updateConstraints()
        didSetupConstraints = true
    }
}


// MARK: Setup
private extension WeatherResumeView{
    func setup(){
    }
}

// MARK: Layout
private extension WeatherResumeView{
    func layoutView(){
        layout(self) { view in
//            view.width == 120
//            view.height == 130
            return
        }
    }
}

// MARK: Style
private extension WeatherResumeView{
    func style(){
        backgroundColor = UIColor.greenColor()
    }
}
