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
    
    let roverImagesButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Mars Rover Images", for: .normal)
        button.setImage(UIImage(named: "25"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(roverPostCardPressed), for: .touchUpInside)
        
        return button
    }()
    
    let eyeInTheSkyeButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Eye-In-The-Sky", for: .normal)
        button.setImage(UIImage(named: "30"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.imageEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 80)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(eyeInTheSkyPressed), for: .touchUpInside)
        
        return button
    }()
    
    let apodButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Picture of the Day", for: .normal)
        button.setImage(UIImage(named: "26"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.imageEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 80)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(apodPressed), for: .touchUpInside)
        
        return button
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
            
            let toImage = UIImage(named: "ipad_background_port_x2")
            transitionImageView(toImage!)
            
        } else {
    
            let toImage = UIImage(named: "ipad_background_hori_x2")
            transitionImageView(toImage!)
            
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
        
        // StackView Setup
        let stackView = UIStackView(arrangedSubviews: [roverImagesButton, eyeInTheSkyeButton, apodButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10
            )])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Transition ImageView
    
    func transitionImageView(_ toImage: UIImage) {
        
        UIView.transition(with: self.backgroundImageView,
                                  duration:5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.backgroundImageView.image = toImage },
                                  completion: nil)
        
    }

}

// MARK: - Navigation

extension HomeViewController {
    
    func roverPostCardPressed() {
        
        let roverImagesViewController = RoverImagesViewController()
        navigationController?.pushViewController(roverImagesViewController, animated: true)
        
    }
    
    func eyeInTheSkyPressed() {
        
        let eyeInTheSkySearchController = EyeInTheSkySearchViewController()
        navigationController?.pushViewController(eyeInTheSkySearchController, animated: true)
        
    }
    
    func apodPressed() {
        
        let nasaClient = NASAClient()
        nasaClient.fetchAPOD { (result) in
            
            switch result {
                
            case .success(let apod):
                
                let imageInfoViewer = ImageInfoViewer(image: apod)
                self.navigationController?.pushViewController(imageInfoViewer, animated: true)
                
            case .failure(let error):
                
                self.presentAlert(withTitle: "Whoops!", message: "There was an error: \(error.localizedDescription)", OkResponseAction: .cancel)
                
            }
        }
        
    }
    
}

