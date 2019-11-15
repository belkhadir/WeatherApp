//
//  CityModelView.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

class CityModelView  {
    
    // Mark: - Instance Properties
    private let city: City
    
    var name: String
    var temperature: String
    var summary: String
    
    // Mark: - Object LifeCycle
    init(city: City) {
        self.city = city
        
        name = city.name
        temperature = String(format:"%.0f" + "℃", city.temperature)
        summary = city.summary
    }
}
