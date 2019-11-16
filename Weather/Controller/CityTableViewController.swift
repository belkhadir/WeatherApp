//
//  CityTableViewController.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit
import CoreData


class CityTableViewController: BaseTableViwController {
    // Mark: - Instance Properties
    fileprivate var citiesModelView = [CityModelView]()
    fileprivate var filteredCity = [CityModelView]()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    // Mark: - The base Configuration for the Controller
    override func prepareTheTableViewController() {
        super.prepareTheTableViewController()
        
        searchController.searchResultsUpdater = self
        view.backgroundColor = .white
        
        // setup the refreshControl
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        refreshControl?.beginRefreshing()
        
        citiesModelView = CityModelView.fetchAllCities()
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        
        let addCityBarButtomItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        navigationItem.setRightBarButton(addCityBarButtomItem, animated: true)
        
        fetchAllDataFromServer()
    }

    // Mark: - Method
    @objc fileprivate func addCity() {
        let newCityTableViewController = NewCityTableViewController(style: .grouped)
        newCityTableViewController.delegate = self
        let nvNewCityVC = UINavigationController(rootViewController: newCityTableViewController)
        present(nvNewCityVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func reloadData() {
        fetchAllDataFromServer()
    }
    
    // fetching data from the server
    fileprivate func fetchAllDataFromServer() {
        refreshControl?.beginRefreshing()
        for (index, element) in citiesModelView.enumerated() {
            DarkskyApiService.forecast(city: element) { [weak self](result) in
                guard let weakSelf = self else { return }
                
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let data):
                    DispatchQueue.main.async {
                        let city = CityModelView(data: data, nameOfCity: element.name)
                        weakSelf.citiesModelView[index] = city
                        city.updateCityCoreData()
                        weakSelf.tableView.reloadData()
                    }
                }
            }
        }
        refreshControl?.endRefreshing()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCity = citiesModelView.filter({ (city) -> Bool in
            return city.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    // Mark: - Data source tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCity.count
        }
        return citiesModelView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        var item: CityModelView
        if isFiltering {
            item = filteredCity[indexPath.item]
        }else {
            item = citiesModelView[indexPath.item]
        }
        cell.configure(cell: item)
        return cell
    }
    
    
    // Mark: - Delegate tableView
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            citiesModelView.remove(at: indexPath.item).deletCityFromCoreData()
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedCity: CityModelView
        if isFiltering {
            selectedCity = filteredCity[indexPath.item]
        }else {
            selectedCity = citiesModelView[indexPath.item]
        }
        let detailViewController = DetailsTableViewController(cityViewModel: selectedCity, style: .grouped)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}

// Mark: - Conform to NewCityDelegate
extension CityTableViewController: NewCityDelegate {
    func didFind(city: MKMapItemModelView) {
        // Before we add the new city to our core data we check
        // if the user added before we ignore it otherwise we add it
        for element in citiesModelView {
            if element.name == city.cityName {
                return
            }
        }
        DarkskyApiService.forecast(latitude: city.latitude, longitude: city.longitude) { [weak self](result) in
            guard let weakSelf = self else { return }
            
            switch result {
            case .failure: print("Error")
            case .success(let data):
                let cityModelView = CityModelView(data: data, nameOfCity: city.cityName)
                weakSelf.citiesModelView.append(cityModelView)
                DispatchQueue.main.async {
                    cityModelView.saveCity()
                    weakSelf.tableView.beginUpdates()
                    let indexPath = IndexPath(item: weakSelf.citiesModelView.count - 1, section: 0)
                    weakSelf.tableView.insertRows(at: [indexPath], with: .automatic)
                    weakSelf.tableView.endUpdates()
                }
            }
        }
    }
}

// Mark: - Conform to Search Results Updating
extension CityTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
