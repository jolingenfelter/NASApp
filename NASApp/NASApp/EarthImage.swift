//
//  EarthImage.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/3/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

enum NASAImageType {
    
    case rover
    case earth
    case apod
    
}

protocol NASAImage {
    
    var type: NASAImageType { get }
    
}

struct EarthImage: DownloadableImage, NASAImage {
    
    let type = NASAImageType.earth
    var activityIndicator: UIActivityIndicatorView?
    var imageURL: URL?
    
    init?(json: json) {
        
        guard let urlString = json["url"] as? String else {
            return nil
        }
        
        self.imageURL = URL(string: urlString)
        
    }
    
}
