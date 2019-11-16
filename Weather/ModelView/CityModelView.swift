//
//  CityModelView.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

class CityModelView  {
    
    // Mark: - Instance Properties
//    private let city: City
    
    var name: String
    var temperatureString: String
    var summary: String
    var latitude: Double
    var longitude: Double
    var temperature: Double
    var imageName: String
    
    private var globalData: GlobalData?
    
    // Mark: - Object LifeCycle
    init(city: City) {
//        self.city = city
        
        name = city.name
        temperature = city.temperature
        temperatureString = String(format:"%.0f" + "℃", city.temperature)
        summary = city.summary
        latitude = city.latitude
        longitude = city.longitude
        imageName = city.imageName
    }
    
    init(data: GlobalData, nameOfCity: String) {
        globalData = data
        name = nameOfCity
        latitude = data.latitude
        longitude = data.longitude
        summary = data.currently.summary ?? ""
        temperatureString = String(format:"%.0f" + "℃", data.currently.temperature ?? 0)
        temperature = data.currently.temperature ?? 0
        imageName = data.currently.icon ?? ""
    }
    
    // Background Image
    var imageView: UIImageView {
        guard let image = ImageFacotory(string: imageName)?.backgroundImage else {
            return UIImageView()
        }
        
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }
    
    // Animate Image
    var iconImages: [UIImage] {
        return ImageFacotory(string: imageName)?.images ?? [UIImage]()
    }
    
    func getDetailData() -> [(key: String, value: Any, icon: String)]{
        guard let currently = globalData?.currently else {
            return [(key: String, value: Any, icon: String)]()
        }
        return  [   ("Humidity", currently.humidity!, "weather_detail_humidity"),
                    ("Pressure", currently.pressure!, "weather_detail_pressure"),
                    ("UV Index", currently.uvIndex!, "weather_detail_uv_index"),
                    ("Visibility", currently.visibility!, "weather_detail_visibility"),]
        
    }

}
