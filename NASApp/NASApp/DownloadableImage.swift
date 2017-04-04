//
//  DownloadableImage.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/4/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

protocol DownloadableImage {
    
    var imageURL: URL? { get }
    
}

extension DownloadableImage {
    
    private func getDataFromImageURL(completion: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        guard let imageURL = imageURL else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            completion(data, response, error)
            
        }.resume()
    }
    
    func downloadImage(completion: @escaping(_ image: UIImage?) -> Void) {
        
        getDataFromImageURL { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                
                if let image = UIImage(data: data) {
                    
                    completion(image)
                    
                } else {
                    
                    print("Unable to download image")
                }
                
            }
        }
        
    }
    
}
