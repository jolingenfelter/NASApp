//
//  ImageViewer.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/9/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import Nuke

class ImageViewer: UIViewController {
    
    var image: DownloadableImage
    var downloadedImage: UIImage?
    var scrollView = ImageScrollView()
    var activityIndicator = UIActivityIndicatorView()
    var saveOrShareButton: UIBarButtonItem?
    
    init(image: DownloadableImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Setup
        view.backgroundColor = AppDelegate.NASABackgroundColor
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        
        // Download image
        
        if let downloadedImage = downloadedImage {
            
            DispatchQueue.main.async {
                self.scrollView.displayImage(downloadedImage)
            }
            
        } else {
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            image.downloadImage { (downloadResult) in
                
                switch downloadResult {
                    
                case .success(let image):
                    
                    self.downloadedImage = image
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.scrollView.displayImage(image)
                    
                case .failure(let error):
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.presentAlert(withTitle: "Oops", message: "There was an error loading the image: \(error.localizedDescription)", OkResponseAction: .toRootViewController)
                    
                }
            }
        }
        
        navBarSetup(forNASAImage: image as! NASAImage)
        
    }
    
    override func viewDidLayoutSubviews() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // NavigationBar
    
    func navBarSetup(forNASAImage nasaImage: NASAImage) {
        
        let saveOrShareButtonImage = imageWithName(image: UIImage(named: "15")!, scaledToSize: CGSize(width: 17, height: 30))
        saveOrShareButton = UIBarButtonItem(image: saveOrShareButtonImage, style: .plain, target: self, action: #selector(saveOrShareImage))
        
        switch nasaImage.type {
            
        case .earth :
            
            navigationItem.rightBarButtonItem = saveOrShareButton
            
        case .rover:
            
            let createPostCardButton = UIBarButtonItem(title: "Postcard", style: .plain, target: self, action: #selector(createPostcardPressed))
            
            navigationItem.rightBarButtonItems = [createPostCardButton, saveOrShareButton!]
    
            let roverImage = image as! RoverImage
            self.title = roverImage.earthDate
            
        case .apod:
            
            navigationItem.rightBarButtonItem = saveOrShareButton
            
            let apod = image as! APOD
            self.title = apod.date
            
        }
        
        
    }
    
    @objc func createPostcardPressed() {
        
        guard let downloadedImage = downloadedImage else {
            return
        }
        
        let createPostCardViewController = CreatePostcardViewController(image: downloadedImage)
        navigationController?.pushViewController(createPostCardViewController, animated: true)
        
    }
    
    @objc func saveOrShareImage() {
        
        guard let image = downloadedImage else {
            return
        }
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = saveOrShareButton!
        
        self.present(activityController, animated: true, completion: nil)
        
    }
    
}
