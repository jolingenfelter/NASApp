//
//  EarthImage.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/3/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

struct EarthImage: DownloadableImage {
    
    var imageURL: URL?
    
    init?(json: json) {
        
        guard let urlString = json["url"] as? String else {
            return nil
        }
        
        self.imageURL = URL(string: urlString)
        
    }
    
}
