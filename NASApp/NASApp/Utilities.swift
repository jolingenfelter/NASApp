//
//  Utilities.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/15/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

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
    
}
