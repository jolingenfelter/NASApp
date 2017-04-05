//
//  HomeViewController.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/1/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "NASApp"
        
        // Check Device Orientation
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            backgroundImageView.image = UIImage(named: "ipad_background_hori_x2")
            
        } else {
            
            backgroundImageView.image = UIImage(named: "ipad_background_port_x2")
            
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            let toImage = UIImage(named: "ipad_background_hori_x2")
            transitionImageView(toImage: toImage!)
            
        } else {
    
            let toImage = UIImage(named: "ipad_background_port_x2")
            transitionImageView(toImage: toImage!)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        // Background ImageView
        self.view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Transition
    
    func transitionImageView(toImage: UIImage) {
        
        UIView.transition(with: self.backgroundImageView,
                                  duration:5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.backgroundImageView.image = toImage },
                                  completion: nil)
        
    }

}

