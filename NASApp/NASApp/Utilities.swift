//
//  Utilities.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/15/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import Photos

enum AlertResponseAction {
    
    case toRootViewController
    case cancel
    
}

extension UIViewController {
    
    func presentAlert(withTitle title: String, message: String, OkResponseAction okResponseAction: AlertResponseAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        // OKAction
        let okToRootVC = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let okToCancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        if okResponseAction == .toRootViewController {
            alert.addAction(okToRootVC)
        } else {
            alert.addAction(okToCancel)
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveImageToPhotoLibrary(image: UIImage) {
        
        PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
            
            switch authorizationStatus {
                
            case .authorized:
                
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(UIViewController.image(_:didFinishSavingWithError:)), nil)
                
            default:
                
                self.presentAlert(withTitle: "Oops!", message: "NASApp does not have permission to access your Photo Library.  This can be changed in the Settings on your device", OkResponseAction: .cancel)
                
            }
        }
        
        
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?) {
        
        guard error == nil else {
            
            presentAlert(withTitle: "Oops!", message: "Unable to save image to your library at this time", OkResponseAction: .cancel)
            
            return
        }
        
        presentAlert(withTitle: "Photo Saved!", message: "This image has been added to your Photo Library", OkResponseAction: .cancel)
        
    }
    
}
