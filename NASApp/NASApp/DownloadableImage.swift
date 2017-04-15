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
    var activityIndicator: UIActivityIndicatorView? { get set }
    
}

extension DownloadableImage {
    
    fileprivate func getDataFromImageURL(_ completion: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        guard let imageURL = imageURL else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            completion(data, response, error)
            
        }.resume()
    }
    
    func downloadImage(_ completion: @escaping(_ image: UIImage?) -> Void) {
        
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        
        getDataFromImageURL { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                
                if let image = UIImage(data: data) {
                    
                    completion(image)
                    self.activityIndicator?.stopAnimating()
                    self.activityIndicator?.isHidden = true
                    
                } else {
                    
                    print("Unable to download image")
                    self.activityIndicator?.stopAnimating()
                    self.activityIndicator?.isHidden = true
                    
                }
                
            }
        }
        
    }
    
}
