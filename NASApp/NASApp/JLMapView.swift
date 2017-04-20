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
    let geocoder = CLGeocoder()
    
    init(searchCompleter: MKLocalSearchCompleter?) {
        self.searchCompleter = nil
        super.init(frame: CGRect.zero)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressToDropPin(gestureRecognizer:)))
        self.addGestureRecognizer(longPress)
        
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
    
    func longPressToDropPin(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self)
        let coordinate = self.convert(point, toCoordinateFrom: self)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            let mapViewPlacemark = MKPlacemark(placemark: placemark)
            
            DispatchQueue.main.async {
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapViewPlacemark.coordinate
                annotation.title = placemark.name
                
                self.removeAnnotations(self.annotations)
                self.addAnnotation(annotation)
                
    
                self.setMapViewRegion(coordinate: annotation.coordinate)
        
                
            }
            
        }
        
    }

}
