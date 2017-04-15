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
    var scrollView = ImageScrollView()
    var activityIndicator = UIActivityIndicatorView()
    
    init(image: DownloadableImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppDelegate.NASABackgroundColor
        view.addSubview(scrollView)
        image.activityIndicator = activityIndicator
        view.addSubview(activityIndicator)
        
        image.downloadImage { (image) in
            
            guard let image = image else {
                return
            }
            
            self.scrollView.displayImage(image)
        }
        
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
        presentAlert(withTitle: "Oh no!", andMessage: "This image is unavailable")
    }
    
}
