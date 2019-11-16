//
//  DetailsViewController.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    // Mark: - Instance Properties
    fileprivate var blockDataDailyModelView = [BlockDataDailyModelView]()
    fileprivate let cityViewModel: CityModelView
    fileprivate var detailCity =  [(key: String, value: Any, icon: String)]()
    
    // It's Helpful Enum Usage Section(section: 0).numberOfRowInSection
    enum Section: Int, CaseIterable {
        case daily
        case detail
        
        var numberOfRowInSection: Int {
            switch self {
            case .daily: return 8
            case .detail: return 4
            }
        }
        
        var heightForHeaderInSection: CGFloat {
            switch self {
            case .daily: return 150.0
            case .detail: return 0.0
            }
        }
        
        init(section: Int) {
            self.init(rawValue: section)!
        }
    }
    
    // Mark: - Object LifeCycle
    init(cityViewModel: CityModelView, style: UITableView.Style) {
        self.cityViewModel = cityViewModel
        detailCity = cityViewModel.getDetailData()
        super.init(style: style)
        prepareController()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - Method
    fileprivate func prepareController() {
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = cityViewModel.imageView
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseIdentifier)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        
        blockDataDailyModelView = cityViewModel.dailyDataModel
        tableView.reloadData()
    }
    
    // Mark: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(section: section).numberOfRowInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(section: indexPath.section)
        
        switch section {
        case .daily:
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseIdentifier, for: indexPath) as! DailyTableViewCell
            let item = blockDataDailyModelView[indexPath.item]
            cell.configure(cell: item)
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
            cell.configure(cell: detailCity[indexPath.item])
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Section(section: section).heightForHeaderInSection
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section(section:  section)
        
        switch section {
        case .daily:
            let header = HeaderView(frame: CGRect(x: 0, y: -150, width: view.frame.width, height: 150.0))
            header.configure(header: cityViewModel)
            return header
        default:
            return UIView()
        }
    }

}
