//
//  DownloadableImage.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/4/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

// Protocol and extension to download image from NASAImage models

protocol DownloadableImage {
    
    var imageURL: URL? { get }
    
}

enum ImageDownloadResult {
    
    case success(UIImage)
    case failure(Error)
    
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
    
    func downloadImage(_ completion: @escaping(_ completion: ImageDownloadResult) -> Void) {
        
        getDataFromImageURL { (data, response, error) in
            
            guard let data = data else {
                
                if let error = error {
                    
                    completion(.failure(error))
                    
                } else {
                    
                    let abnormalError = NSError(domain: ANTNetworkingErrorDomain, code: AbnormalError, userInfo: nil)
                    completion(.failure(abnormalError))
                    
                }
                
                return
            }
            
            DispatchQueue.main.async {
                
                if let image = UIImage(data: data) {
                    
                    completion(.success(image))
                    
                }
                
            }
        }
        
    }
    
}
