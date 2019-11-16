//
//  CityModelView.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit
import CoreData

class CityModelView  {
    
    // Mark: - Instance Properties
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
    
    // Mark: - Compute Properties
    var dailyDataModel: [BlockDataDailyModelView]  {
        guard let daily = globalData?.daily?.data else {
            return  [BlockDataDailyModelView]()
        }
        
        return daily.map { BlockDataDailyModelView(blockdataDaily: $0) }
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
    
    // Animated Image
    var iconImages: [UIImage] {
        return ImageFacotory(string: imageName)?.images ?? [UIImage]()
    }
    
    
    // Mark: - Method
    func getDetailData() -> [(key: String, value: Any, icon: String)]{
        guard let currently = globalData?.currently else {
            return [(key: String, value: Any, icon: String)]()
        }
        return  [   ("Humidity", currently.humidity!, "weather_detail_humidity"),
                    ("Pressure", currently.pressure!, "weather_detail_pressure"),
                    ("UV Index", currently.uvIndex!, "weather_detail_uv_index"),
                    ("Visibility", currently.visibility!, "weather_detail_visibility"),]
        
    }
    
    // Mark: - CRUD for Core Data
    func findCityInCoreData() -> City? {
        let request: NSFetchRequest<City> = City.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        do {
            let cities = try sharedContext.fetch(request)
            if cities.count == 0 { return nil}
            return cities[0]
        }catch _ { return nil }
    }
    
    func updateCityCoreData() {
        guard let city = findCityInCoreData() else { return }
        city.setValue(temperature, forKey: "temperature")
        city.setValue(latitude, forKey: "latitude")
        city.setValue(longitude, forKey: "longitude")
        city.setValue(summary, forKey: "summary")
        saveContext()
    }

    func deletCityFromCoreData() {
        guard let city = findCityInCoreData() else { return }
        sharedContext.delete(city)
        saveContext()
    }
    
}
