//
//  WeatherDaysForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 03/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import Foundation
import Cartography

class WeatherDaysForecastView: UIView {
    private var didSetupConstraints = false
    private var forecastCells = Array<WeatherDayForecastView>()

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
private extension WeatherDaysForecastView{
    func setup(){
        for i in 0..<7 {
            let cell = WeatherDayForecastView(frame: CGRectZero)
            forecastCells.append(cell)
            addSubview(cell)
        }
    }
}

// MARK: Layout
private extension WeatherDaysForecastView{
    func layoutView(){
        setTranslatesAutoresizingMaskIntoConstraints(false)
        layout(forecastCells.first!) { view in
            view.top == view.superview!.top
            return
        }
        
        for idx in 1..<forecastCells.count {
            let previousCell = forecastCells[idx-1]
            let cell = forecastCells[idx]
            layout(cell, previousCell) { view, view2 in
                view.top == view2.bottom
                return
            }
        }
        for cell in forecastCells {
            layout(cell) { view in
                view.left == view.superview!.left
                view.right == view.superview!.right
            }
        }
        layout(forecastCells.last!) { view in
            view.bottom == view.superview!.bottom
            return
        }
    }
}


// MARK: Style
private extension WeatherDaysForecastView{
    func style(){
    }
}


// MARK: Render
extension WeatherDaysForecastView{
    func render(){
        for view in forecastCells {
            view.render()
        }
    }
}
