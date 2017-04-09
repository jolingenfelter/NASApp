//
//  RoverCell.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/6/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import Nuke

class RoverCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RoverCell"
    let roverImageView = UIImageView()
    
    override func layoutSubviews() {
        
        self.contentView.addSubview(roverImageView)
        roverImageView.translatesAutoresizingMaskIntoConstraints = false
        roverImageView.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            roverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            roverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            roverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
        
    }
    
    func configureCell(withImage image: RoverImage) {
        
        if let imageURL = image.imageURL {
            
            Nuke.loadImage(with: imageURL, into: roverImageView)
            
        }
        
    }
    
}
