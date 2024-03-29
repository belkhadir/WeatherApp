//
//  NewCityTableViewController.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class NewCityTableViewController: BaseTableViwController {

    // Mark: - Instance Properties
    fileprivate let cities = [City]()
    var matchingItems: [MKMapItem] = []
    
    weak var delegate: NewCityDelegate?
    
    
    
    // Mark: - The base Configuration for the Controller
    override func prepareTheTableViewController() {
        super.prepareTheTableViewController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        
        searchController.searchResultsUpdater = self
    }
    
    // Mark: - Method
    func parseAddress(selectedItem:MKPlacemark) -> String {
           
           // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
        selectedItem.thoroughfare != nil) ? " " : ""
           
           // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
           
           // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
               selectedItem.administrativeArea != nil) ? " " : ""
           
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
           
        return addressLine
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
       
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = matchingItems[indexPath.row].placemark
        delegate?.didFind(city: MKMapItemModelView(item: city))
        dismiss(animated: true, completion: nil)
    }
       

}

// Mark: - Conform to Search Results Updating
extension NewCityTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }

}
