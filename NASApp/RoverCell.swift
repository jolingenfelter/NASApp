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
    var messageButton: UIButton?
    var saveButton: UIButton?
    
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
        
        let stackView = UIStackView(arrangedSubviews: [saveButton!, messageButton!])
        contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.widthAnchor.constraint(equalToConstant: 60)
            ])
        
    }
    
    func configureCell(withImage image: RoverImage) {
        
        self.clipsToBounds = true
        
        if roverImageView == nil {
            roverImageView = UIImageView()
            contentView.addSubview(roverImageView!)
        }
        
        if messageButton == nil {
            messageButton = UIButton()
            messageButton!.setImage(UIImage(named: "10"), for: .normal)
            messageButton!.imageView?.contentMode = .scaleAspectFit
            contentView.addSubview(messageButton!)
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
