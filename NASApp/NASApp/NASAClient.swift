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
    
    private var apiKey: String {
        
        return "X42XktIUyfM17ZpPRjTZ1E6asX6vRxXBOC0EWqir"
        
    }
    
    var baseURL: URL {
        
        return URL(string:"https://api.nasa.gov/")!
        
    }
    
    func urlRequest(withParameters parameters: [String : Any]?) -> URLRequest? {
        
        var url: URL?
        
        switch self {
        
        case .rover:
            
            url = URL(fileURLWithPath: "mars-photos/api/v1/rovers/curiosity/photos?&sol=1000&api_key=\(apiKey)", relativeTo: baseURL)
            
        case .earth:
            
            guard let params = parameters, let latitude = params["latitude"] as? Double, let longitude = params["longitude"] as? Double else {
                
                return nil
            }
            
            url = URL(fileURLWithPath: "planetary/earth/imagery?lat=\(latitude)&lon=\(longitude)&api_key=\(apiKey)", relativeTo: baseURL)
        
        }
        
        
        if let url = url {
            
            return URLRequest(url: url)
            
        } else {
            
            return nil
            
        }
    }
    
    
}

final class NASAClient: APIClient {
    
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // Fetch Earth Image for Address
    func fetchEarthImage(for address: String, completion: @escaping(APIResult<EarthImage>) -> Void) {
        
        
        
    }
    
    // Fetch Rover Images
    func fetchRoverImages(completion: @escaping(APIResult<[RoverImage]>) -> Void) {
        
        guard let request = NASAImages.rover.urlRequest(withParameters: nil) else {
            return
        }
        
       fetch(request, parse: { (json) -> [RoverImage]? in
        
        if let roverImages = json["photos"] as? [[String : AnyObject]] {
            
            return roverImages.flatMap({ (imageDictionary) in
                return RoverImage(json: json)
            })
            
        } else {
           
            return nil
            
        }
        
       }, completion: completion)
        
    }
    
}
































