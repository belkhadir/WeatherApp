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
    let _ = City(name: "Casablanca", latitude: 0, longitude: 0, temperature: 0, summary: "", icon: "", insertInto: sharedContext)
    let _ = City(name: "Rabat", latitude: 0, longitude: 0, temperature: 0, summary: "", icon: "", insertInto: sharedContext)
    let _ = City(name: "Marrakech", latitude: 0, longitude: 0, temperature: 0, summary: "", icon: "", insertInto: sharedContext)
    let _ = City(name: "Tangier", latitude: 0, longitude: 0, temperature: 0, summary: "", icon: "", insertInto: sharedContext)
    let _ = City(name: "Fes", latitude: 0, longitude: 0, temperature: 0, summary: "", icon: "", insertInto: sharedContext)
    
    saveContext()
}
