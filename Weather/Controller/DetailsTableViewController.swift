//
//  DetailsViewController.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    fileprivate var blockDataDailyModelView = [BlockDataDailyModelView]()
    let cityViewModel: CityModelView
    
    init(cityViewModel: CityModelView, style: UITableView.Style) {
        self.cityViewModel = cityViewModel
        super.init(style: style)
        prepareController()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockDataDailyModelView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseIdentifier, for: indexPath) as! DailyTableViewCell
        let item = blockDataDailyModelView[indexPath.item]
        cell.configure(cell: item)
        return cell
    }

    fileprivate func prepareController() {
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = cityViewModel.imageView
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseIdentifier)
        getDailyData()
    }
    
    fileprivate func getDailyData() {
        print(cityViewModel.latitude)
        DarkskyApiService.forecast(city: cityViewModel) {[weak self] (result) in
            guard let weakSelf = self else { return }
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let data):
                guard let daily = data.daily?.data else { return }
                weakSelf.blockDataDailyModelView = daily.map { BlockDataDailyModelView(blockdataDaily: $0) }
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView(frame: CGRect(x: 0, y: -150, width: view.frame.width, height: 150.0))
        header.configure(header: cityViewModel)
        return header
    }
}
