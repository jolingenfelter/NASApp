//
//  JLMapView.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/18/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class JLMapView: MKMapView {
    
    var searchCompleter: MKLocalSearchCompleter?
    
    init(searchCompleter: MKLocalSearchCompleter?) {
        
        self.searchCompleter = nil
        super.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMapViewRegion(coordinate: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegionMake(coordinate, span)
        
        self.setRegion(region, animated: true)
        searchCompleter?.region = region
    }

    func dropPinAndZoom(placemark: MKPlacemark) {
        
        self.removeAnnotations(self.annotations)
        self.removeOverlays(self.overlays)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        self.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        self.setRegion(region, animated: true)
        
        let location = CLLocation(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
        self.add(MKCircle(center: location.coordinate, radius: 50))
        
    }
    
    // Get the location and zoom in on searched location
    func mapViewSearchAndZoomInOn(searchCompletion: MKLocalSearchCompletion, completion: @escaping (CLLocation) -> Void) {
        
        let searchRequest = MKLocalSearchRequest(completion: searchCompletion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            
            DispatchQueue.main.async {
                
                guard let response = response, let mapItem = response.mapItems.first else {
                    return
                }
                
                let placemark = mapItem.placemark
                
                guard let location = placemark.location else {
                    return
                }
                
                completion(location)
                
                self.dropPinAndZoom(placemark: placemark)
                
            }
            
        }
        
    }

}
