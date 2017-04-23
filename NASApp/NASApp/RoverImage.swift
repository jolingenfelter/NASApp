//
//  RoverImage.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/3/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

struct RoverImage: DownloadableImage, NASAImage {
    
    var type = NASAImageType.rover
    var activityIndicator: UIActivityIndicatorView?
    var imageURL: URL?
    
    init?(json: json) {
        
        guard let imageURL = json["img_src"] as? String else {
            return nil
        }
        
        self.imageURL = URL(string: imageURL)
        
    }
    
}
