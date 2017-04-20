//
//  JLGeocoder.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/4/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import CoreLocation

class JLGeocoder {
    
    let geocoder = CLGeocoder()
    
    // Get address
    func address(fromString string: String, completion: @escaping (CLLocation?, Error?) -> Void) {
        
        geocoder.geocodeAddressString(string) { (placemarks, error) in
            
            if let placemark = placemarks?.first, let location = placemark.location {
                
                completion(location, nil)
                
            } else {
                
                completion(nil, error)
                
            }
            
        }
        
    }
    
}
