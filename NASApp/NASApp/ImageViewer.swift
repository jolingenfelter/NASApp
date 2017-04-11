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
    
    var imageURL: URL
    var imageView: ImageView?
    var scrollView = UIScrollView()
    
    init(imageURL: URL) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppDelegate.NASABackgroundColor

        // ScrollView Setup
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.flashScrollIndicators()
        
        // ImageView Setup
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        imageView?.contentMode = .scaleAspectFit
        Nuke.loadImage(with: imageURL, into: imageView!)
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView!)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        imageView?.frame.size = CGSize(width: view.bounds.size.height, height: view.bounds.size.width)
        imageView?.center = CGPoint(x: view.bounds.height/2, y: view.bounds.width/2)
    }
    
    override func viewDidLayoutSubviews() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UIScrollViewDelegate

extension ImageViewer: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
