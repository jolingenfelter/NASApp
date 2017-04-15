//
//  Utilities.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/15/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title: String, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
