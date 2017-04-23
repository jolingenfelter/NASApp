//
//  ImageInfoViewer.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ImageInfoViewer: UIViewController {
    
    let backgroundImageView = UIImageView()
    let apod: APOD
    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        textView.text = self.apod.explanation
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.font = textView.font?.withSize(24)
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
        
        // ImageView
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textView.heightAnchor.constraint(equalToConstant: 400)
            ])
        
    }
    
    func configureView() {
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        backgroundImageView.image = UIImage(named: "ipad_background_port_x2")
        
        self.title = apod.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
