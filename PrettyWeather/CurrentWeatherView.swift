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
    private let cityLbl = UILabel()
    private let maxTempLbl = UILabel()
    private let minTempLbl = UILabel()
    private let iconLbl = UILabel()
    private let weatherLbl = UILabel()
    private let currentTempLbl = UILabel()
    
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
        
        layout(currentTempLbl) { view in
            view.width == view.height
            return
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
            view.width == 40
        }
        
        layout(maxTempLbl, minTempLbl) { view, view2 in
            view.top == view2.top
            view.height == view2.height
            view.width == view2.width
        }
    
        layout(maxTempLbl, currentTempLbl) { view, view2 in
            view.right == view2.right
            return
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
        backgroundColor = UIColor.greenColor()
        iconLbl.backgroundColor = UIColor.brownColor()
        weatherLbl.backgroundColor = UIColor.brownColor()
        minTempLbl.backgroundColor = UIColor.brownColor()
        maxTempLbl.backgroundColor = UIColor.brownColor()
        currentTempLbl.backgroundColor = UIColor.redColor()
        cityLbl.backgroundColor = UIColor.redColor()
    }
}

// MARK: Render
extension CurrentWeatherView{
    func render(weatherCondition: WeatherCondition){
//        iconLbl.backgroundColor = UIColor.brownColor()
        
        weatherLbl.text = weatherCondition.weather
        minTempLbl.text = "\(Int(round(weatherCondition.minTempCelsius)))°"
        maxTempLbl.text = "\(Int(round(weatherCondition.maxTempCelsius)))°"
        currentTempLbl.text = "\(Int(round(weatherCondition.tempCelsius)))°"
        cityLbl.text = weatherCondition.cityName ?? ""
    }
}
