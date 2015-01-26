//
//  PrettyWeatherViewController.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 25/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import UIKit
import Cartography

class PrettyWeatherViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let resumeView = WeatherResumeView(frame: CGRectZero)
    private let forecastView = WeatherForecastView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
    }
}


// MARK: Setup
private extension PrettyWeatherViewController{
    func setup(){
        view.backgroundColor = UIColor.grayColor()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(resumeView)
        contentView.addSubview(forecastView)
    }
}

// MARK: Layout
private extension PrettyWeatherViewController{
    func layoutView(){
        layout(scrollView) { view in
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
            view.right == view.superview!.right
        }
        
        layout(contentView) { view in
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
            view.right == view.superview!.right
        }
        
        layout(resumeView) { view in
            view.left == view.superview!.left + 20
            return
        }
        
        layout(forecastView, resumeView) { view, view2 in
            view.top == view2.bottom + 20
            view.left == view.superview!.left + 20
            view.right == view.superview!.right - 20
            view.bottom == view.superview!.bottom - 20
        }
        
        let resumeToInsect: Float = Float(view.frame.height) - Float(resumeView.frame.height) - 20
        layout(resumeView) { view in
            view.top == view.superview!.top + resumeToInsect
            return
        }
    }
}

// MARK: Style
private extension PrettyWeatherViewController{
    func style(){
        view.backgroundColor = UIColor.whiteColor()
    }
}
