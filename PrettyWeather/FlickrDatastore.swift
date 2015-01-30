//
//  FlickrDatastore.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 27/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import FlickrKit

class FlickrDatastore {
    private let OBJECTIVE_FLICKR_API_KEY = "dd23a324bf96f064fc8960799637a0e9"
    private let OBJECTIVE_FLICKR_API_SHARED_SECRET = "53ac95957294758f"
    
    func retrieveImageAtLat(lat: Double, lon: Double, closure: (image: UIImage) -> Void){
        let fk = FlickrKit.sharedFlickrKit()
        fk.initializeWithAPIKey(OBJECTIVE_FLICKR_API_KEY, sharedSecret: OBJECTIVE_FLICKR_API_SHARED_SECRET)
        
//        let lat = "51.5072"
//        let lon = "0.1275"
//        let tag = "rain"
        
        fk.call("flickr.photos.search", args: [
            "group_id": "1463451@N25",
            "lat": "\(lat)",
            "lon": "\(lon)",
//            "tags": tag,
            "radius": "10"
            ], maxCacheAge: FKDUMaxAgeOneHour) { (response, error) -> Void in
                if let response = response as? [String:AnyObject]{
                    let r = response as [String:AnyObject]
                    if let photos = response["photos"] as? [String:AnyObject] {
                        if let listOfPhotos: AnyObject = photos["photo"] {
                            if listOfPhotos.count > 0 {
                                let randomIndex = Int(arc4random_uniform(UInt32(listOfPhotos.count)))
                                let photo = listOfPhotos[randomIndex] as [String:AnyObject]
                                let url = fk.photoURLForSize(FKPhotoSizeMedium640, fromPhotoDictionary: photo)
                                let image = UIImage(data: NSData(contentsOfURL: url)!)
                                dispatch_async(dispatch_get_main_queue()){
                                    closure(image: image!)
                                }
                            }
                        }
                    }
                } else {
                    println(error)
                    println(response)
                }
        }
    }
}