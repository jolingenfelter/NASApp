//
//  NASAClient.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/2/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation
import Contacts

enum NASAImages: Endpoint {
    
    case rover
    case earth
    
    fileprivate var apiKey: String {
        
        return "X42XktIUyfM17ZpPRjTZ1E6asX6vRxXBOC0EWqir"
        
    }
    
    var baseURLString: String {
        
        return "https://api.nasa.gov/"
        
    }
    
    func createURL(withParameters parameters: [String : Any]?) -> URL? {
        
        var url: URL?
        
        switch self {
        
        case .rover:
            
            url = URL(string: baseURLString + "mars-photos/api/v1/rovers/curiosity/photos?&sol=1000&api_key=\(apiKey)")
            
        case .earth:
            
            guard let params = parameters, let latitude = params["latitude"] as? Double, let longitude = params["longitude"] as? Double else {
                
                return nil
            }
            
            url = URL(string: baseURLString + "planetary/earth/imagery?lat=\(latitude)&lon=\(longitude)&api_key=\(apiKey)")
        
        }
        
        guard let finalURL = url else {
            return nil
        }
        
        return finalURL
    }
    
    
}

final class NASAClient: APIClient {
    
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    let geocoder = JLGeocoder()
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // Fetch Earth Image for Address
    func fetchEarthImage(forAddress address: String, completion: @escaping(APIResult<EarthImage>) -> Void) {
        
        geocoder.address(fromString: address) { (location, error) in
            
            guard let location = location else {
                return
            }
            
            guard let url = NASAImages.earth.createURL(withParameters: ["latitude" : location.coordinate.latitude, "longitude" : location.coordinate.longitude]) else {
                return
            }
            
            let request = URLRequest(url: url)
            
            self.fetch(request, parse: { (json) -> EarthImage? in
                
                let imageDictionary = json
                
                return EarthImage(json: imageDictionary)
                
            }, completion: completion)
            
        }
    }
    
    // Fetch Rover Images
    func fetchRoverImages(_ completion: @escaping(APIResult<[RoverImage]>) -> Void) {
        
        guard let url = NASAImages.rover.createURL(withParameters: nil) else {
            return
        }
        
        let request = URLRequest(url: url)
        
       fetch(request, parse: { (json) -> [RoverImage]? in
    
        if let roverImages = json["photos"] as? [[String : AnyObject]] {
            
            return roverImages.flatMap({ (imageDictionary) in
                
                return RoverImage(json: imageDictionary)
                
            })
            
        } else {
           
            return nil
            
        }
        
       }, completion: completion)
        
    }
    
}
