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
    private let scrollView = UIScrollView()
    private var forecastCells = Array<WeatherHourForecastView>()
    
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
        for i in 0..<7 {
            let cell = WeatherHourForecastView(frame: CGRectZero)
            forecastCells.append(cell)
            scrollView.addSubview(cell)
        }
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
    }
}

// MARK: Layout
private extension WeatherHourlyForecastView{
    func layoutView(){
        layout(self) { view in
            view.height == 100
        }
        layout(scrollView) { view in
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
            view.right == view.superview!.right
        }
        
        layout(forecastCells.first!) { view in
            view.left == view.superview!.left
        }
        layout(forecastCells.last!) { view in
            view.right == view.superview!.right
        }
        
        for idx in 1..<forecastCells.count {
            let previousCell = forecastCells[idx-1]
            let cell = forecastCells[idx]
            layout(previousCell, cell) { view, view2 in
                view.right == view2.left + 5
            }
        }
        for cell in forecastCells {
            layout(cell) { view in
                view.width == view.height
                view.height == view.superview!.height
                view.top == view.superview!.top
            }
        }
    }
}

// MARK: Style
private extension WeatherHourlyForecastView{
    func style(){
    }
}

// MARK: Render
extension WeatherHourlyForecastView{
    func render(){
        for view in forecastCells {
            view.render()
        }
    }
}
