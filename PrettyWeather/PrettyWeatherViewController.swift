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
    private let backgroundView = UIImageView()
    private let overlayView = UIImageView()
    private let scrollView = UIScrollView()
    private let resumeView = WeatherResumeView(frame: CGRectZero)
    private let hourlyForecastView = WeatherHourlyForecastView(frame: CGRectZero)
    private let daysForecastView = WeatherDaysForecastView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render()
        FlickrDatastore().callflickr(){ image in
            self.backgroundView.image = image
        }
        WeatherDatastore().updateForecast(51.5072, longitude: 0.1275) {
            weatherConditions in
            println(weatherConditions)
        }
    }
}


// MARK: Setup
private extension PrettyWeatherViewController{
    func setup(){
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
        
        overlayView.contentMode = .ScaleAspectFill
        overlayView.clipsToBounds = true
        view.addSubview(overlayView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(resumeView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(daysForecastView)
        view.addSubview(scrollView)
    }
}

// MARK: Layout
extension PrettyWeatherViewController{
    func layoutView() {
        layout(backgroundView) { view in
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
            view.right == view.superview!.right
        }
        
        layout(scrollView) { view in
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
            view.right == view.superview!.right
        }

        layout(resumeView) { view in
            view.left == view.superview!.left + 20
            return
        }

        layout(hourlyForecastView, resumeView) { view, view2 in
            view.top == view2.bottom + 20
            view.width == view.superview!.width - 40
            view.centerX == view.superview!.centerX
        }
        
        layout(daysForecastView, hourlyForecastView) { view, view2 in
            view.top == view2.bottom
            view.width == view2.width
            view.bottom == view.superview!.bottom - 20
            view.centerX == view.superview!.centerX
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
        view.backgroundColor = UIColor.grayColor()
        daysForecastView.backgroundColor = UIColor.redColor()
    }
}

// MARK: Render
private extension PrettyWeatherViewController{
    func render(){
        backgroundView.image = UIImage(named: "StockPhoto")
    }
}
