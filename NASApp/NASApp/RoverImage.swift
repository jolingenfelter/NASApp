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
    var imageURL: URL?
    var earthDate: String?
    
    init?(json: json) {
        
        guard let imageURL = json["img_src"] as? String, let earthDate = json["earth_date"] as? String else {
            return nil
        }
        
        self.imageURL = URL(string: imageURL)
        self.earthDate = earthDate
        
    }
    
}
