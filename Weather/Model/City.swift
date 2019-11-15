//
//  City.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation


final class City {
    
    // Mark: - Instance Properties
    var name: String
    var latitude: Double
    var longitude: Double
    
    var temperature: Double
    var summary: String
    var icon: String
    
    // Mark: - Object Life cycle
    init(name: String, latitude: Double = 0.0,
         longitude: Double = 0.0, temperature: Double = 14,
        summary: String = "", icon: String = "") {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
        self.summary = summary
        self.icon = icon
    }
    
    static let cities = [
        City(name: "Casablanca", summary: "Cloudy"),
        City(name: "Rabat", summary: "Cloudy"),
        City(name: "Marrakech", summary: "Cloudy"),
        City(name: "Tangier", summary: "Cloudy"),
        City(name: "Fes", summary: "Cloudy")
    ]
}
