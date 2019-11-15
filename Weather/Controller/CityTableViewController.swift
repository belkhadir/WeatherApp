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
        citiesModelView = fetchCityFromCoreData()
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        
    }
    
    @objc fileprivate func startEditing() {
        tableView.setEditing(true, animated: true)
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
}
