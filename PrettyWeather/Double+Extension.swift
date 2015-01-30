//
//  Double+Extension.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 30/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation

extension Double {
    func roundToInt() -> Int{
        return Int(round(self))
    }
}