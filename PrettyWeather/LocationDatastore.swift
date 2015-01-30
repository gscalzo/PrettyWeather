//
//  LocationDatastore.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 28/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let lat: Double
    let lon: Double
    let cityName: String
}

class LocationDatastore: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    typealias LocationClosure = (Location) -> Void
    private let onLocationFound: LocationClosure
    
    init(closure: LocationClosure){
        onLocationFound = closure
        super.init()
        locationManager.delegate = self
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        startUpdating()
    }
    
    
    private func startUpdating() {
        //        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    private func stopUpdating() {
        //        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        NSLog("Error: \(error)")
        dispatch_async(dispatch_get_main_queue()){
            self.onLocationFound(Location(lat: 37.3175, lon: 122.0419, cityName: "Cupertino"))
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as CLLocation
        var coord = locationObj.coordinate
        
        dispatch_async(dispatch_get_main_queue()){
            self.onLocationFound(Location(lat: coord.latitude, lon: coord.longitude, cityName: "Pippo"))
        }
        
        stopUpdating()
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            switch status {
            case .Restricted:
                NSLog("Denied access: Restricted Access to location")
            case .Denied:
                NSLog("Denied access: User denied access to location")
            case .NotDetermined:
                NSLog("Denied access: Status not determined")
            default:
                NSLog("Allowed to location Access")
                startUpdating()
            }
    }
}