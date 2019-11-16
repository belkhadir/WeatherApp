//
//  BaseTableViewController.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class BaseTableViwController: UITableViewController {
    
    // Mark: - Object LifeCycle
    override init(style: UITableView.Style) {
        super.init(style: style)
        prepareTheTableViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // Mark: - Method
    internal func prepareTheTableViewController() {
        
    }
}
