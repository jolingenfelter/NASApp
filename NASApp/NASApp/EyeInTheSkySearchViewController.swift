//
//  EyeInTheSkySearchViewController.swift
//  NASApp
//
//  Created by Joanna Lingenfelter on 4/16/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit
import MapKit

class EyeInTheSkySearchViewController: UIViewController {
    
    // View Variables
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        //tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isHidden = true
        
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let searchBar: UISearchBar
    let mapView = MKMapView()
    
    init() {
        searchBar = searchController.searchBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
        
        setupSearchController()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // SearchBar
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        // MapView
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UITableViewDelegate

extension EyeInTheSkySearchViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

//extension EyeInTheSkySearchViewController: UITableViewDataSource {
//    
//}

// MARK: - SearchBar

extension EyeInTheSkySearchViewController {
    
    func setupSearchController() {
        
        searchController.hidesNavigationBarDuringPresentation = false
        
    }
    
}
