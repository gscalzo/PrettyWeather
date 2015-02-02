//
//  WeatherDaysForecastView.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 25/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import Cartography

class WeatherDaysForecastView: UIView {
    private var didSetupConstraints = false
    private var forecastCells = Array<WeatherDayForecastView>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
extension WeatherDaysForecastView{
    
    override func updateConstraints() {
        if didSetupConstraints {
            super.updateConstraints()
            return
        }

        // siccome non settiamo constraints sulla vie stessa, ma solo sulle sue subvies, dobiamo disabilitare autoresizemaskintocontrsints, che fa di default Cartograpy
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
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
        
        super.updateConstraints()
        didSetupConstraints = true
    }
}

// MARK: Render
extension WeatherDaysForecastView{
    func render(weatherConditions: Array<WeatherCondition>){
        for (idx, view) in enumerate(forecastCells) {
            view.render(weatherConditions[idx])
        }
    }
}
