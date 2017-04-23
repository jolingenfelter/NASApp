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
        image.activityIndicator = activityIndicator
        view.addSubview(activityIndicator)
        
        image.downloadImage { (image) in
            
            guard let image = image else {
                
                self.presentAlert(withTitle: "Uh oh!", message: "This image cannot be downloaded at this time.  Check your network connection", OkResponseAction: .toRootViewController)
                
                return
            }
            
            self.downloadedImage = image
            self.scrollView.displayImage(image)
        }
        
        navBarSetup(forNASAImage: image as! NASAImage)
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(failedDownloadAlert), name: NSNotification.Name(rawValue: "UnableToDownloadImage"), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UnableToDownloadImage"), object: nil)
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
    
    func failedDownloadAlert() {
        presentAlert(withTitle: "Oh no!", message: "This image is unavailable", OkResponseAction: .toRootViewController)
    }
    
    // NavigationBar
    
    func navBarSetup(forNASAImage nasaImage: NASAImage) {
        
        let saveOrShareButtonImage = imageWithName(image: UIImage(named: "15")!, scaledToSize: CGSize(width: 17, height: 30))
        saveOrShareButton = UIBarButtonItem(image: saveOrShareButtonImage, style: .plain, target: self, action: #selector(saveOrShareImage))
        
        switch nasaImage.type {
            
        case .earth:
            
            navigationItem.rightBarButtonItem = saveOrShareButton
            
        case .rover:
            
            navigationItem.rightBarButtonItem = saveOrShareButton
            
        case .apod:
            
            let infoButton = UIBarButtonItem(title: "info", style: .plain, target: self, action: #selector(infoPressed))
            navigationItem.rightBarButtonItems = [infoButton, saveOrShareButton!]
            
            let apod = image as! APOD
            self.title = apod.date
            
        }
        
        
    }
    
    func infoPressed() {
        
    }
    
    func saveOrShareImage() {
        
        guard let image = downloadedImage else {
            
            presentAlert(withTitle: "Oops!", message: "Unable to save or share image.  Check your network connection", OkResponseAction: .cancel)
            
            return
        }
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = saveOrShareButton!
        
        self.present(activityController, animated: true, completion: nil)
        
    }
    
}
