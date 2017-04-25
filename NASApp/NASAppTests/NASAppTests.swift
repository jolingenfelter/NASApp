//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Joanna Lingenfelter on 4/24/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import XCTest
@testable import NASApp
import CoreLocation

class NASAppTests: XCTestCase {
    
    let nasaClient = NASAClient()
    
    let latitude = CLLocationDegrees(exactly: 38.0293)
    let longitude = CLLocationDegrees(exactly: 78.4767)
    
    lazy var testLocation: CLLocation? = {
        
        guard let latitude = self.latitude, let longitude = self.longitude else {
            return nil
        }
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }()
   
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchEarthImageForLocationSuccess() {
        
        guard let testLocation = testLocation else {
            XCTFail("Location is nil")
            return
        }
        
        let testExpectation = expectation(description: "Earth Image present")
        
        nasaClient.fetchEarthImage(forLocation: testLocation) { (result) in
            
            switch result {
                
            case .success(_) :
                
                testExpectation.fulfill()
                
            case .failure(_) :
                
                break
                
            }
            
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    
    }
    
}
