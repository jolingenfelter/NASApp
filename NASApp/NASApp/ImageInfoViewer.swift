//
//  ImageInfoViewer.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/22/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ImageInfoViewer: UIViewController {
    
    let imageView = UIImageView()
    let textView = UITextView()
    let apod: APOD
    
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
    
    func configureView() {
        
        imageView.image = UIImage(named: "ipad_background_port_x2")
        textView.text = apod.explanation
        self.title = apod.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
