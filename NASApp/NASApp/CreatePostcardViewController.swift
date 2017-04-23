//
//  CreatePostcardViewController.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/23/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import Nuke

class CreatePostcardViewController: UIViewController {
    
    let roverImage: RoverImage
    var backgroundImageView = UIImageView()
    
    lazy var textField: UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = AppDelegate.NASABarColor
        textField.font = textField.font?.withSize(18)
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1.5
        
        return textField
    }()
    
    lazy var previewButton: UIButton = {
        
        let button = UIButton()
        
        
        return button
    }()
    
    lazy var roverImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    init(roverImage: RoverImage) {
        
        self.roverImage = roverImage
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

    }
    
    override func viewDidLayoutSubviews() {
        
        // BackgroundImageView
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        // RoverImageView
        
        view.addSubview(roverImageView)
        roverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roverImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            roverImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            roverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            roverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        backgroundImageView.image = UIImage(named: "ipad_background_port_x2")
        
        guard let imageURL = roverImage.imageURL else {
            return
        }
        
        Nuke.loadImage(with: imageURL, into: roverImageView)
        
    }
    
    // MARK: - Navigation
    
    func navBarSetup() {
        
        let sendPostCardButton = UIBarButtonItem(title: "Send Postcard", style: .plain, target: self, action: #selector(sendPostcardPressed))
        navigationItem.rightBarButtonItem = sendPostCardButton
        
    }
    
    func sendPostcardPressed() {
        
    }

}
