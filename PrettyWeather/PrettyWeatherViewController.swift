//
//  PrettyWeatherViewController.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 02/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import Cartography
import FXBlurView

class PrettyWeatherViewController: UIViewController {
    private let gradientView = UIView()
    private let overlayView = UIImageView()
    private let backgroundView = UIImageView()
    private let scrollView = UIScrollView()
    private let currentWeatherView = CurrentWeatherView(frame: CGRectZero)
    private let hourlyForecastView = WeatherHourlyForecastView(frame: CGRectZero)
    private let daysForecastView = WeatherDaysForecastView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render(UIImage(named: "DefaultImage"))
        renderSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let lat:Double = 48.8567
        let lon:Double = 2.3508
        
        FlickrDatastore().retrieveImageAtLat(lat, lon: lon){ image in
            self.render(image)
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
        view.addSubview(gradientView)

        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(currentWeatherView)
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
        layout(gradientView) { view in
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
        
        layout(currentWeatherView) { view in
            view.width == view.superview!.width
            view.centerX == view.superview!.centerX
        }
        
        layout(hourlyForecastView, currentWeatherView) { view, view2 in
            view.top == view2.bottom + 20
            view.width == view.superview!.width
            view.centerX == view.superview!.centerX
        }
        
        layout(daysForecastView, hourlyForecastView) { view, view2 in
            view.top == view2.bottom
            view.width == view2.width
            view.bottom == view.superview!.bottom - 20
            view.centerX == view.superview!.centerX
        }
        
        let currentWeatherInsect: Float = Float(view.frame.height) - Float(currentWeatherView.frame.height) - 10
        layout(currentWeatherView) { view in
            view.top == view.superview!.top + currentWeatherInsect
            return
        }
    }
}

// MARK: Style
private extension PrettyWeatherViewController{
    func style(){
        gradientView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        let blackColor = UIColor(white: 0, alpha: 0.0)
        let clearColor = UIColor(white: 0, alpha: 1.0)
        
        gradientLayer.colors = [blackColor.CGColor, clearColor.CGColor]
        
        gradientLayer.startPoint = CGPointMake(1.0, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 1.0)
        gradientView.layer.mask = gradientLayer
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
    
    func renderSubviews() {
        currentWeatherView.render()
        hourlyForecastView.render()
        daysForecastView.render()
    }
}

// MARK: UIScrollViewDelegate
extension PrettyWeatherViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let treshold: CGFloat = CGFloat(view.frame.height)/2
        overlayView.alpha = min (1.0, offset/treshold)
        
    }
}
