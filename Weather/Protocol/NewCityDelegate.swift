//
//  NewCityDelegate.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

protocol NewCityDelegate: class {
    func didFind(city: MKMapItemModelView)
}
