//
//  PrettyWeatherViewController.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 02/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import Cartography

class PrettyWeatherViewController: UIViewController {
    private let backgroundView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render(UIImage(named: "DefaultImage"))
    }
}

// MARK: Setup
private extension PrettyWeatherViewController{
    func setup(){
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
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
    }
}

// MARK: Style
private extension PrettyWeatherViewController{
    func style(){
    }
}

// MARK: Render
private extension PrettyWeatherViewController{
    func render(image: UIImage?){
        if let image = image {
            backgroundView.image = image
        }
    }
}
