//
//  MKMapItemModelView.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import MapKit


class MKMapItemModelView {
    // Mark: - Instance Properties
    var cityName: String = ""
    var countryName: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    // Mark: - Object LifeCycle
    init(item: MKPlacemark) {
        
        let splitElement = item.title?.split(separator: ",")
        
        guard let city = splitElement?[0] else { return }
        guard let country = splitElement?[1] else { return }
        guard let latitude =  item.location?.coordinate.latitude else { return }
        guard let longitude = item.location?.coordinate.longitude else { return }
        
        self.cityName = String(city)
        self.countryName = String(country)
        self.latitude = latitude
        self.longitude = longitude
        
    }
}
