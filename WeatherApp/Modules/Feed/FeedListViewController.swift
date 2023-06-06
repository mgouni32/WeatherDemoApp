//
//  FeedListViewController.swift
//  WeatherApp
//
//  Created by Mounika Gouni on 02/06/23.
//

import UIKit

class FeedListViewController: UIViewController {

    lazy var viewModel: FeedListViewModel = {
        return FeedListViewModel()
    }()
    
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    // - Constants
    private let locationManager = LocationManager()
    private var dataSource: FeedTableViewDataSource<FeedTableViewCell,FeedList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
        
        guard let exposedLocation = self.locationManager.exposedLocation else {
                   print("*** Error in \(#function): exposedLocation is nil")
                   return
               }
               
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            var city = ""
            if let town = placemark.locality {
                self.viewModel.getWeatherDataBy(name: city)
            }
        }
    }
    
    private func initView() {
        self.navigationItem.title = "Loading..."
        self.feedTableView.tableFooterView = UIView()
    }
    
    private func initBinding() {
        viewModel.bindFeedViewModelToController = {[weak self](status) in
            switch status {
            case .success:
                DispatchQueue.main.async {
                    self?.navigationItem.title = "WEATHER"
                    self?.updateDataSource()
                }
            case .failed:
                DispatchQueue.main.async {
                    self?.navigationItem.title = "Failed to fetch weather info"
                }
            }
        }
    }
    
    private func updateDataSource() {
        
        self.dataSource = FeedTableViewDataSource(cellIdentifier: "FeedTableViewCell", items: self.viewModel.feedList.results ?? [], configureCell: { (cell, feed) in
            cell.nameLbl.text = feed.name
            cell.humidityLbl.text = "Humidity: \(feed.humidity ?? 0) \nTemparature: \(feed.temp ?? 0)"
        })
                
        DispatchQueue.main.async {
            self.feedTableView.dataSource = self.dataSource
            self.feedTableView.reloadData()
        }
    }
}

extension FeedListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let city = searchBar.searchTextField.text {
            viewModel.getWeatherDataBy(name: city)
        }
    }
}
