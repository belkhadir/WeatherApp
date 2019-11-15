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
//    private let city: City
    
    var name: String
    var temperatureString: String
    var summary: String
    var latitude: Double
    var longitude: Double
    var temperature: Double
    
    // Mark: - Object LifeCycle
    init(city: City) {
//        self.city = city
        
        name = city.name
        temperature = city.temperature
        temperatureString = String(format:"%.0f" + "℃", city.temperature)
        summary = city.summary
        latitude = city.latitude
        longitude = city.longitude
    }
    
    init(data: GlobalData, nameOfCity: String) {
        name = nameOfCity
        latitude = data.latitude
        longitude = data.longitude
        summary = data.currently.summary ?? ""
        temperatureString = String(format:"%.0f" + "℃", data.currently.temperature ?? 0)
        temperature = data.currently.temperature ?? 0
    }
}
