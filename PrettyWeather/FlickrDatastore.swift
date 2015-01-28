//
//  FlickrDatastore.swift
//  PrettyWeather
//
//  Created by Giordano Scalzo on 27/01/2015.
//  Copyright (c) 2015 Effective Code Ltd. All rights reserved.
//

import Foundation
import FlickrKit

class NextCallObj: NSObject {
    typealias NextCallClosure = () -> Void
    
    var callClosure: NextCallClosure
    init(callClosure: NextCallClosure = {}){
        self.callClosure = callClosure
        super.init()
    }
    
}

class FlickrDatastore {
    private let OBJECTIVE_FLICKR_API_KEY = "dd23a324bf96f064fc8960799637a0e9"
    private let OBJECTIVE_FLICKR_API_SHARED_SECRET = "53ac95957294758f"
    //    private var context: OFFlickrAPIContext!
    //    private var flickrRequest: OFFlickrAPIRequest!
    
    typealias NextCall = () -> Void
    
    func callflickr(closure: (image: UIImage) -> Void){
        let fk = FlickrKit.sharedFlickrKit()
        fk.initializeWithAPIKey(OBJECTIVE_FLICKR_API_KEY, sharedSecret: OBJECTIVE_FLICKR_API_SHARED_SECRET)
        
        let lat = "51.5072"
        let lon = "0.1275"
        let tag = "rain"
        
        fk.call("flickr.photos.search", args: [
            "group_id": "1463451@N25",
            "lat": lat,
            "lon": lon,
            "tags": tag,
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
                    
                    println(response)
                } else {
                    println(error)
                    println(response)
                }
        }
    }
    
    //        [[FlickrKit sharedFlickrKit] call:@"flickr.photos.search" args:@{@"user_id": self.userID, @"per_page": @"15"} maxCacheAge:FKDUMaxAgeOneHour completion:^(NSDictionary *response, NSError *error) {
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                if (response) {
    //                    // extract images from the response dictionary
    //                } else {
    //                    // show the error
    //                }
    //                });
    //        }];
    
    //        let fk = FlickrKit.sh
    //
    //        FlickrKit *fk = [FlickrKit sharedFlickrKit];
    //        FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    //        [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
    //        // Note this is not the main thread!
    //        if (response) {
    //        NSMutableArray *photoURLs = [NSMutableArray array];
    //        for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
    //        NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
    //        [photoURLs addObject:url];
    //        }
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //        // Any GUI related operations here
    //        });
    //        }
    //        }];
    //
    //         context = OFFlickrAPIContext(APIKey: OBJECTIVE_FLICKR_API_KEY, sharedSecret: OBJECTIVE_FLICKR_API_SHARED_SECRET)
    //
    //         flickrRequest = OFFlickrAPIRequest(APIContext: context!)
    //        let nextCall = NextCallObj() {
    //            println("21321")
    //        }
    //        flickrRequest!.sessionInfo = nextCall
    //        //        self.flickrRequest.sessionInfo = sessionInfo;
    //        flickrRequest!.delegate = self
    //
    //        flickrRequest!.callAPIMethodWithGET("flickr.photos.search", arguments:
    //        ["group_id": "1463451@N25",
    //            "tags": "london,snow",
    //            "radius": "10"
    //        ])
    //    }
    //
    //    func flickrAPIRequest(inRequest: OFFlickrAPIRequest!, didCompleteWithResponse inResponseDictionary: [NSObject : AnyObject]){
    //        (inRequest.sessionInfo as NextCallObj).callClosure()
    //    }
    //
    //    func flickrAPIRequest(inRequest: OFFlickrAPIRequest!, didFailWithError inError: NSError!) {
    //
    //    }
    
}