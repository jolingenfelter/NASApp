//
//  ImageInfoViewer.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import Nuke

class ImageInfoViewer: UIViewController {
    
    let backgroundImageView = UIImageView()
    let apod: APOD
    let activityIndicator = UIActivityIndicatorView()
    var downloadedImage: UIImage?
    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        textView.text = self.apod.explanation
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = textView.font?.withSize(14)
        textView.textColor = .white
        
        
        return textView
    }()
    
    lazy var apodImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    init(image: APOD) {
        
        self.apod = image
    
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
        
        
        // APODImageView
        
        view.addSubview(apodImageView)
        apodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            apodImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            apodImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            apodImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            apodImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        //  ActivityIndicator
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: apodImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: apodImageView.centerYAnchor)
            ])
        
        
        // TextField
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: apodImageView.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
        
    }
    
    func configureView() {
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        backgroundImageView.image = UIImage(named: "ipad_background_port_x2")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        apod.downloadImage { [weak self] (downloadResult) in
            
            switch downloadResult {
                
            case .success(let image):
                
                self?.apodImageView.image = image
                self?.downloadedImage = image
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                
            case .failure(let error):
                
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.presentAlert(withTitle: "Oh no!", message: "There was a problem getting the picture of the day: \(error.localizedDescription)", OkResponseAction: .toRootViewController)
                
            }
            
        }
        
        self.title = apod.date
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(apodImageTapped))
        view.addGestureRecognizer(tapGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - Gestures

extension ImageInfoViewer {
    
    @objc func apodImageTapped() {
        
        let imageViewer = ImageViewer(image: apod)
        imageViewer.downloadedImage = downloadedImage
        navigationController?.pushViewController(imageViewer, animated: true)
        
    }
    
}
