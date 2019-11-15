//
//  CityTableViewController.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class CityTableViewController: UITableViewController {
    // Mark: - Instance Properties
    fileprivate let cities = City.cities
    
    
    // Mark: - Instance Properties
    override init(style: UITableView.Style) {
        super.init(style: style)
        view.backgroundColor = .white
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    
    // Mark: - Data source tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        let item = cities[indexPath.item]
        cell.configure(cell: item)
        return cell
    }
}
