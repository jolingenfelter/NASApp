//
//  APIClient.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/2/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import Foundation

// Error Responses

public let TRENetworkingErrorDomain = "com.jolingenfelter.NASApp.NetworkingError"
public let ANTNetworkingErrorDomain = "com.jolingenfelter.NASApp.AbnormalError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20
public let AbnormalError: Int = 30

// JSON

typealias json = [String : AnyObject]
typealias jsonTaskCompletion = (json?, HTTPURLResponse?, NSError?) -> Void
typealias jsonTask = URLSessionDataTask

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol jsonDecodable {
    init?(json: json)
}

protocol Endpoint {
    var baseURLString: String { get }
    func createURL(withParameters parameters: [String: Any]?) -> URL?
}

protocol APIClient {
    
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    init(configuration: URLSessionConfiguration)
    
}

extension APIClient {
    
    func jsonTaskWithRequest(_ request: URLRequest, completion: @escaping jsonTaskCompletion) -> jsonTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPURLResponse = response as? HTTPURLResponse else {
                
                let userInfoDict = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                
                let error = NSError(domain: TRENetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfoDict)
                
                completion(nil, nil, error)
                
                return
                
            }
            
            if data == nil {
                
                if let error = error {
                    completion(nil, nil, error as NSError)
                }
                
            } else {
                
                switch HTTPURLResponse.statusCode {
                    
                case 200:
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? json
                        
                        completion(json, HTTPURLResponse, nil)
                        
                    } catch let error as NSError {
                        
                        completion(nil, HTTPURLResponse, error)
                        
                    }
                    
                default: print("Received HTTPResponse: \(HTTPURLResponse.statusCode) - not handled")
                    
                }
                
            }
            
        }
        
        return task
        
    }
    
    
    func fetch<T>(_ request: URLRequest, parse: @escaping (json) -> T?, completion: @escaping (APIResult<T>) -> Void) {
        
        let task = jsonTaskWithRequest(request) { (json, response, error) in
            
            DispatchQueue.main.async {
                
                guard let json = json else {
                    
                    if let error = error {
                        
                        completion(.failure(error))
                        
                    } else {
                        
                        let abnormalError = NSError(domain: ANTNetworkingErrorDomain, code: AbnormalError, userInfo: nil)
                        
                        completion(.failure(abnormalError))
                    
                    }
                
                return
                
            }
            
                if let value = parse(json) {
                
                    completion(.success(value))
                
                } else {
               
                    let error = NSError(domain: TRENetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                
                    completion(.failure(error))
            
                }
            
            
            }
    
    
        }
        
        task.resume()
    
    }
    
    
}
