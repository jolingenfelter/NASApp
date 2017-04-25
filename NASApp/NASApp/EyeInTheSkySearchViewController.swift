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
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isHidden = true
        
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let searchBar: UISearchBar
    var searchItems: [MKLocalSearchCompletion] = []
    var selectedSearchCompletion: MKLocalSearchCompletion?
    var mapView: JLMapView
    var searchedLocation: CLLocation?
    
    lazy var searchCompleter: MKLocalSearchCompleter = {
        
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        
        return completer
    }()
    
    init() {
        
        searchBar = searchController.searchBar
        mapView = JLMapView(searchCompleter: nil)
        
        super.init(nibName: nil, bundle: nil)
        
        mapView.searchCompleter = searchCompleter
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
        navBarSetup()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // SearchBar
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        guard let navigationController = navigationController else {
            return
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor),
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
        
        
        // TableView
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    func navBarSetup() {
        
        let satelliteViewButton = UIBarButtonItem(title: "Satellite View", style: .plain, target: self, action: #selector(satelliteViewPressed))
        navigationItem.rightBarButtonItem = satelliteViewButton
        
    }
    
    func satelliteViewPressed() {
        
        if searchedLocation == nil {
            
            presentAlert(withTitle: "Oops!", message: "You must select a location to see the satellite image", OkResponseAction: .cancel)
            
        } else {
            
            guard let searchCompletion = selectedSearchCompletion else {
                return
            }
            
            let nasaClient = NASAClient()
            nasaClient.fetchEarthImage(forLocation: searchedLocation!, completion: { (result) in
                
                switch result {
                    
                case .success(let earthImage):
                    
                    let imageViewer = ImageViewer(image: earthImage)
                    imageViewer.title = searchCompletion.title
                    self.navigationController?.pushViewController(imageViewer, animated: true)
                    
                case .failure(let error):
                    
                    self.presentAlert(withTitle: "Oops", message: "Something went wrong: \(error.localizedDescription)", OkResponseAction: .cancel)
                    
                }
                
            })
        
            
        }
        
    }
    
    deinit {
        searchController.view.removeFromSuperview()
    }

}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension EyeInTheSkySearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchBar.text = searchItems[indexPath.row].title
        tableView.isHidden = true
        searchBar.resignFirstResponder()
        
        let searchCompletion = searchItems[indexPath.row]
        selectedSearchCompletion = searchCompletion
        
        mapView.mapViewSearchAndZoomInOn(searchCompletion: searchCompletion) { (location) in
            self.searchedLocation = location
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let location = searchItems[indexPath.row]
        
        cell.textLabel?.text = location.title
        cell.detailTextLabel?.text = location.subtitle
        
        return cell
        
    }
    
}


// MARK: - SearchBar

extension EyeInTheSkySearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func setupSearchController() {
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchBar.text else {
            return
        }
        
        searchCompleter.queryFragment = searchText
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if searchBar.text != nil {
            
            searchBar.text = searchItems.first?.title
            
            guard let searchCompletion = searchItems.first else {
                return
            }
            
            selectedSearchCompletion = searchCompletion

            mapView.mapViewSearchAndZoomInOn(searchCompletion: searchCompletion) { (location) in
                self.searchedLocation = location
            }
            
        }
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.isHidden = true
        searchItems = []
        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
    
}

// MARK: - MKLocalSearchCompleterDelegate 

extension EyeInTheSkySearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchItems = completer.results
        tableView.reloadData()
    }
    
}
