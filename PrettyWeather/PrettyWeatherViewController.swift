//
//  PrettyWeatherViewController.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 25/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import UIKit
import Cartography
import FXBlurView

class PrettyWeatherViewController: UIViewController {
    private let backgroundView = UIImageView()
    private let overlayView = UIImageView()
    private let scrollView = UIScrollView()
    private let resumeView = WeatherResumeView(frame: CGRectZero)
    private let hourlyForecastView = WeatherHourlyForecastView(frame: CGRectZero)
    private let daysForecastView = WeatherDaysForecastView(frame: CGRectZero)
    private var locationDatastore: LocationDatastore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render(UIImage(named: "StockPhoto"))
        locationDatastore = LocationDatastore() { [weak self] location in
            FlickrDatastore().retrieveImageAtLat(location.lat, lon: location.lon){ image in
                self?.render(image)
                return
            }
            let weatherDatastore = WeatherDatastore()
            weatherDatastore.retrieveCurrentWeatherAtLat(location.lat, lon: location.lon) {
                currentWeatherConditions in
                self?.renderCurrent(currentWeatherConditions)
                return
            }
            weatherDatastore.retrieveHourlyForecastAtLat(location.lat, lon: location.lon) {
                hourlyWeatherConditions in
                self?.renderHourly(hourlyWeatherConditions)
                return
            }
            weatherDatastore.retrieveDailyForecastAtLat(location.lat, lon: location.lon, dayCnt: 7) {
                hourlyWeatherConditions in
                self?.renderHourly(hourlyWeatherConditions)
                return
            }
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
        scrollView.delegate = self
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
        layout(overlayView) { view in
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
    func render(image: UIImage?){
        if let image = image {
            backgroundView.image = image
            overlayView.image = image.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
            overlayView.alpha = 0
        }
    }
    
    func renderCurrent(currentWeatherConditions: WeatherCondition){
        NSLog("\(currentWeatherConditions.cityName)")
        NSLog("\(currentWeatherConditions.weather)")
        NSLog("\(currentWeatherConditions.time)")
        NSLog("\(currentWeatherConditions.maxTempKelvin)")
        NSLog("\(currentWeatherConditions.minTempKelvin)")
        NSLog("\(currentWeatherConditions.maxTempCelsius)")
        NSLog("\(currentWeatherConditions.minTempCelsius)")
        NSLog("Flush")
    }
    func renderHourly(weatherConditions: Array<WeatherCondition>){
        for currentWeatherConditions in weatherConditions {
            NSLog("\(currentWeatherConditions.cityName)")
            NSLog("\(currentWeatherConditions.weather)")
            NSLog("\(currentWeatherConditions.time)")
            NSLog("\(currentWeatherConditions.maxTempKelvin)")
            NSLog("\(currentWeatherConditions.minTempKelvin)")
            NSLog("\(currentWeatherConditions.maxTempCelsius)")
            NSLog("\(currentWeatherConditions.minTempCelsius)")
            NSLog("Flush")
        }
    }
    
    
    func renderDaily(weatherConditions: Array<WeatherCondition>){
        for currentWeatherConditions in weatherConditions {
            NSLog("\(currentWeatherConditions.cityName)")
            NSLog("\(currentWeatherConditions.weather)")
            NSLog("\(currentWeatherConditions.time)")
            NSLog("\(currentWeatherConditions.maxTempKelvin)")
            NSLog("\(currentWeatherConditions.minTempKelvin)")
            NSLog("\(currentWeatherConditions.maxTempCelsius)")
            NSLog("\(currentWeatherConditions.minTempCelsius)")
            NSLog("Flush")
        }
    }
}

// MARK: UIScrollViewDelegate
extension PrettyWeatherViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let magicNumer: CGFloat = CGFloat(view.frame.height)/2
        overlayView.alpha = min (1.0, offset/magicNumer)
        
    }
}

