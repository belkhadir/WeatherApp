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
        for element in citiesModelView {
            DarkskyApiService.forecast(city: element) { [weak self](result) in
                guard let weakSelf = self else { return }
                
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let data):
                    print("1")
                    DispatchQueue.main.async {
                        let city = CityModelView(data: data, nameOfCity: element.name)
                        weakSelf.updatedCitiesModelView.append(city)
                        weakSelf.citiesModelView.removeAll{ city.name == $0.name }
                        weakSelf.citiesModelView.append(city)
                        weakSelf.updateCityCoreData(city: element)
                        weakSelf.tableView.reloadData()
                    }
                }
            }
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
        DarkskyApiService.forecast(latitude: city.latitude, longitude: city.longitude) { [weak self](result) in
            guard let weakSelf = self else { return }
            
            switch result {
            case .failure: print("Error")
            case .success(let data):
                let cityModelView = CityModelView(data: data, nameOfCity: city.cityName)
                weakSelf.citiesModelView.append(cityModelView)
                DispatchQueue.main.async {
                    let _ = City(newCity: city, insertInto: sharedContext)
                    weakSelf.tableView.beginUpdates()
                    let indexPath = IndexPath(item: weakSelf.citiesModelView.count - 1, section: 0)
                    weakSelf.tableView.insertRows(at: [indexPath], with: .automatic)
                    weakSelf.tableView.endUpdates()
                }
            }
        }
    }
}

func filterDuplicate() {
    
}
