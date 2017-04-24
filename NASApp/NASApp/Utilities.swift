//
//  Utilities.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/15/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import MapKit

enum AlertResponseAction {
    
    case toRootViewController
    case cancel
    
}

// MARK: - UIViewController Extension

extension UIViewController {
    
    func presentAlert(withTitle title: String, message: String, OkResponseAction okResponseAction: AlertResponseAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        // Cancel
        let okToRootVC = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let okToCancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        // Back to rootVC
        if okResponseAction == .toRootViewController {
            alert.addAction(okToRootVC)
        } else {
            alert.addAction(okToCancel)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

// Resize Images

func imageWithName(image: UIImage, scaledToSize newSize: CGSize) -> UIImage? {
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
    
    guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
        return nil
    }
    
    UIGraphicsEndImageContext()
    
    return newImage
    
}
