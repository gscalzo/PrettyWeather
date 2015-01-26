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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layoutView()
        style()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 120, height: 130)
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
//        layout(self) { view in
//            view.width == 120
//            view.height == 130
//        }
    }
}

// MARK: Style
private extension WeatherResumeView{
    func style(){
        backgroundColor = UIColor.greenColor()
    }
}
