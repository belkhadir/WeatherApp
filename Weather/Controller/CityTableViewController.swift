//
//  CityTableViewController.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit
import CoreData


class CityTableViewController: UITableViewController {
    // Mark: - Instance Properties
    fileprivate var citiesModelView = [CityModelView]()
    fileprivate let myGroup = DispatchGroup()
    fileprivate var updatedCitiesModelView = [CityModelView]()
    
    // Mark: - Instance Properties
    override init(style: UITableView.Style) {
        super.init(style: style)
        prepareTheTableViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Mark: - Method
    fileprivate func fetchCityFromCoreData() -> [CityModelView] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        
        do {
            return try sharedContext.fetch(request).map { CityModelView(city: $0) }
        }catch _ { return  [CityModelView]() }
    }
    
    fileprivate func prepareTheTableViewController() {
        view.backgroundColor = .white
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        citiesModelView = fetchCityFromCoreData()
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        
        let addCityBarButtomItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        navigationItem.setRightBarButton(addCityBarButtomItem, animated: true)
        fetchAllDataFromServer()
    }
    
    @objc fileprivate func addCity() {
        let newCityTableViewController = NewCityTableViewController(style: .grouped)
        newCityTableViewController.delegate = self
        let nvNewCityVC = UINavigationController(rootViewController: newCityTableViewController)
        present(nvNewCityVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func reloadData() {
        fetchAllDataFromServer()
    }
    
    // Mark: - Data source tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesModelView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        let item = citiesModelView[indexPath.item]
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
            citiesModelView.remove(at: indexPath.item)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            saveContext()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = citiesModelView[indexPath.item]
        
    }
    
    // Using dispatch groups to fire an asynchronous callback when all your requests finish.
    // https://stackoverflow.com/questions/35906568/wait-until-swift-for-loop-with-asynchronous-network-requests-finishes-executing?rq=1
    fileprivate func fetchAllDataFromServer() {
        updatedCitiesModelView.removeAll()
        for element in citiesModelView {
            myGroup.enter()
            DarkskyApiService.forecast(city: element) { [weak self](result) in
                // Maintain the retain cycle
                guard let weakSelf = self else { return }
                
                switch result {
                case .failure:
                    print("Error")
                case .success(let data):
                    let city = CityModelView(data: data, nameOfCity: element.name)
                    weakSelf.updatedCitiesModelView.append(city)
                    weakSelf.myGroup.leave()
                }
            }
        }
        
        myGroup.notify(queue: .main) { [weak self] in
            // Maintain the retain cycle
            guard let weakSelf = self else { return }
            
            for element in weakSelf.updatedCitiesModelView {
                weakSelf.updateCityCoreData(city: element)
            }
            weakSelf.citiesModelView.removeAll()
            weakSelf.citiesModelView = weakSelf.updatedCitiesModelView
            weakSelf.tableView.reloadData()
            weakSelf.refreshControl?.endRefreshing()
        }
        
    }
    
    func updateCityCoreData(city: CityModelView) {
        let request: NSFetchRequest<City> = City.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", city.name)
        do {
            let cities = try sharedContext.fetch(request)
            if cities.count == 0 { return }
            cities[0].setValue(city.temperature, forKey: "temperature")
            cities[0].setValue(city.latitude, forKey: "latitude")
            cities[0].setValue(city.longitude, forKey: "longitude")
            cities[0].setValue(city.summary, forKey: "summary")
            saveContext()
        }catch _ {}
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
        
        // Save it To Core data
        let newCity = City(newCity: city, insertInto: sharedContext)
        saveContext()
        citiesModelView.append(CityModelView(city: newCity))
        tableView.beginUpdates()
        let indexPath = IndexPath(item: citiesModelView.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    

}
