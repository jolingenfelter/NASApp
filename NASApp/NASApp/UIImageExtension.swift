//
//  UIImageExtension.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

extension UIImage {
    
    func addText(_ drawText: NSString, atPoint point: CGPoint) -> UIImage? {
        
        // Setup the image context
        UIGraphicsBeginImageContext(self.size)
        
        // Font Attributes
        let textColor = UIColor.white
        let textFont = UIFont.boldSystemFont(ofSize: 80)
        let strokeColor = UIColor.black
        let strokeWidth = -1.5
        
        let textFontAttributes = [NSAttributedStringKey.font: textFont, NSAttributedStringKey.foregroundColor: textColor, NSAttributedStringKey.strokeColor: strokeColor, NSAttributedStringKey.strokeWidth: strokeWidth] as [NSAttributedStringKey : Any]
        
        // Put image into a rectangle as large as the original
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Create a point within the space that is as big as the image
        let rect = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        
        // Draw the text onto the image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        guard let imageWithText = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        // End the context
        UIGraphicsEndImageContext()
        
        return imageWithText
    }
    
    
}
