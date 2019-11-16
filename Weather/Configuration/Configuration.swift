//
//  Configuration.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation


// Casablanca, Rabat, Marrakech, Tangier and Fes
func addDefaultCityToCoreData() {
    let _ = City(name: "Casablanca", latitude: 33.589886, longitude: -7.603869, temperature: 0, summary: "", icon: "")
    let _ = City(name: "Rabat", latitude: 34.020882, longitude: -6.841650, temperature: 0, summary: "", icon: "")
    let _ = City(name: "Marrakech", latitude: 31.669746, longitude: -7.973328, temperature: 0, summary: "", icon: "")
    let _ = City(name: "Tangier", latitude: 35.76727, longitude: -5.79975, temperature: 0, summary: "", icon: "")
    let _ = City(name: "Fes", latitude: 34.03715, longitude: -4.9998, temperature: 0, summary: "", icon: "")
    
    saveContext()
}
