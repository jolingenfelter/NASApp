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
        flowLayout.itemSize = CGSize(width: 50, height: 50)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register CollectionViewCell
        self.collectionView.register(RoverCell.self, forCellWithReuseIdentifier: RoverCell.reuseIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UICollectionViewDataSource

extension RoverImagesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCell.reuseIdentifier, for: indexPath) as! RoverCell
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension RoverImagesViewController: UICollectionViewDelegate {
    
}
