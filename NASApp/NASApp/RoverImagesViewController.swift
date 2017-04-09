//
//  RoverImagesViewController.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/6/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class RoverImagesViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        
        return collectionView
        
    }()
    
    var roverImages: [RoverImage]?
    let nasaClient = NASAClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = AppDelegate.NASABackgroundColor
        self.title = "Mars Rover Images"
        let backButton = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Register CollectionViewCell
        self.collectionView.register(RoverCell.self, forCellWithReuseIdentifier: RoverCell.reuseIdentifier)
        
        collectionView.dataSource = self
        
        fetchRoverImages()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
    }
    
    func fetchRoverImages() {
        
        nasaClient.fetchRoverImages { (result) in
            
            switch result {
                
            case .success(let images) :
                
                self.roverImages = images
                self.collectionView.reloadData()
            
            case .failure(let error):
                
                print(error.localizedDescription)
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UICollectionViewDataSource

extension RoverImagesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCell.reuseIdentifier, for: indexPath) as! RoverCell
        
        if let roverImages = roverImages {
            
            let cellImage = roverImages[indexPath.row]
            cell.configureCell(withImage: cellImage)
            
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension RoverImagesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let roverImages = roverImages else {
            return
        }
        
        let selectedImage = roverImages[indexPath.row]
        
        guard let imageURL = selectedImage.imageURL else {
            return
        }
        
        let imageViewer = ImageViewer(imageURL: imageURL)
        self.navigationController?.pushViewController(imageViewer, animated: true)
        
    }
    
}
