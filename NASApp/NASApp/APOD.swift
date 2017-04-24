//
//  Astronomy Image of the Day.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

struct APOD: DownloadableImage, NASAImage {
    
    var type = NASAImageType.apod
    var imageURL: URL?
    var date: String?
    var explanation: String?
    
    init?(json: json) {
        
        guard let imageURL = json["hdurl"] as? String, let date = json["date"] as? String, let explanation = json["explanation"] as? String else {
            return
        }
        
        self.imageURL = URL(string: imageURL)
        self.date = date
        self.explanation = explanation
    }
    
}
