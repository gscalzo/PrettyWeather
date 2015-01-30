//
//  CurrentWeatherView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 25/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import UIKit
import Cartography


class CurrentWeatherView: UIView {
    private let currentTempLbl = UILabel()
    private let maxTempLbl = UILabel()
    private let minTempLbl = UILabel()
    private let iconLbl = UILabel()
    private let weatherLbl = UILabel()
    
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
        if didSetupConstraints == false {
            super.updateConstraints()
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }
}

// MARK: Setup
private extension CurrentWeatherView{
    func setup(){
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
            view.width == 300
            view.height == 140
        }
    }
}

// MARK: Style
private extension CurrentWeatherView{
    func style(){
        backgroundColor = UIColor.greenColor()
    }
}
