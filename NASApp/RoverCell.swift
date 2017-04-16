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
    var saveButton: UIButton?
    
    override func layoutSubviews() {
        
        guard let roverImageView = roverImageView, let saveButton = saveButton else {
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
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 20)
            ])
        
    }
    
    func configureCell(withImage image: RoverImage) {
        
        self.clipsToBounds = true
        
        if roverImageView == nil {
            roverImageView = UIImageView()
            contentView.addSubview(roverImageView!)
        }
        
        if saveButton == nil {
            saveButton = UIButton()
            saveButton!.setImage(UIImage(named: "15"), for: .normal)
            saveButton!.imageView?.contentMode = .scaleAspectFit
            contentView.addSubview(saveButton!)
        }
        
        if let imageURL = image.imageURL {
            
            Nuke.loadImage(with: imageURL, into: roverImageView!)
            
        }
        
    }
    
}
