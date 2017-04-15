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
    var roverImageView: UIImageView?
    
    override func layoutSubviews() {
        
        guard let roverImageView = roverImageView else {
            return
        }

        roverImageView.translatesAutoresizingMaskIntoConstraints = false
        roverImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            roverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            roverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            roverImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
        
    }
    
    func configureCell(withImage image: RoverImage) {
        
        self.clipsToBounds = true
        
        if roverImageView == nil {
            roverImageView = UIImageView()
            contentView.addSubview(roverImageView!)
        }
        
        if let imageURL = image.imageURL {
            
            Nuke.loadImage(with: imageURL, into: roverImageView!)
            
        }
        
    }
    
}
