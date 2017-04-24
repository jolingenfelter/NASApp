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
    
    let downloadedImage: UIImage
    var backgroundImageView = UIImageView()
    var postcard: UIImage?
    var sendPostCardButton: UIBarButtonItem?
    
    lazy var textField: UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = AppDelegate.NASABarColor
        textField.font = textField.font?.withSize(18)
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 5
        
        let indentation = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.leftView = indentation
        
        return textField
    }()
    
    lazy var createPostcardButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Create Postcard", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(AppDelegate.NASABarColor, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(createPostcard), for: .touchUpInside)
        
        return button
    }()
    
    lazy var roverImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    init(image: UIImage) {
        
        self.downloadedImage = image
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navBarSetup()
        

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
        
        // TextField
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: roverImageView.bottomAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        // CreatePostcardButton
        
        view.addSubview(createPostcardButton)
        createPostcardButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createPostcardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createPostcardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createPostcardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            createPostcardButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        backgroundImageView.image = UIImage(named: "ipad_background_port_x2")
        
        roverImageView.image = downloadedImage
        
    }
    
    // MARK: - Postcard
    
    func createPostcard() {
        
        textField.resignFirstResponder()
        
        if textField.text != "" {
            
            let text = textField.text! as NSString
            let point = CGPoint(x: 20, y: downloadedImage.size.height - 80)
            postcard = downloadedImage.addText(text, atPoint: point)
            roverImageView.image = postcard
            
        } else {
        
            presentAlert(withTitle: "Oops!", message: "It looks like your postcard doesn't have a message", OkResponseAction: .cancel)
            
        }
        
    }
    
    func sendPostcardPressed() {
        
        guard let postcard = postcard else {
            
            presentAlert(withTitle: "Whoops!", message: "Create a postcard first!", OkResponseAction: .cancel)
            
            return
        }
        
        let activityController = UIActivityViewController(activityItems: [postcard], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = sendPostCardButton
        
        self.present(activityController, animated: true, completion: nil)

        
    }
    
    // MARK: - Navigation
    
    func navBarSetup() {
        
        sendPostCardButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendPostcardPressed))
        navigationItem.rightBarButtonItem = sendPostCardButton

    }

}
