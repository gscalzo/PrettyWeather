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
    private let contentView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layoutView()
        style()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func intrinsicContentSize() -> CGSize {
//        return CGSize(width: 320, height: 400)
//    }
//    
}


// MARK: Setup
private extension WeatherForecastView{
    func setup(){
        addSubview(contentView)
    }
}

// MARK: Layout
private extension WeatherForecastView{
    func layoutView(){
                layout(contentView) { view in
//                    view.width == 120
                    view.left == view.superview!.left + 10
                    view.top == view.superview!.top + 10
                    view.bottom == view.superview!.bottom + 10
                    view.height == 500
                    view.width == 200
                }
    }
}

// MARK: Style
private extension WeatherForecastView{
    func style(){
        backgroundColor = UIColor.blueColor()
        contentView.backgroundColor = UIColor.redColor()
    }
}
