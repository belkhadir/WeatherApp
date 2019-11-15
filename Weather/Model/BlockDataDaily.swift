//
//  BlockDataDaily.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

class BlockDataDaily: Decodable {
    var temperatureMin: Double?
    var temperatureMax: Double?
    var temperatureHigh: Double?
    var temperatureLow: Double?
    var time: Date?
    var summary: String?
    var icon: String?
    var precipIntensity: Double?
    var precipType: String?
    var temperature: Double?
    var apparentTemperature: Double?
    var dewPoint: Double?
    var humidity: Double?
    var pressure: Double?
    var windSpeed: Double?
    var windGust: Double?
    var windBearing: Double?
    var cloudCover: Double?
    var uvIndex: Int?
    var visibility: Double?
    var ozone: Double?
    var sunriseTime: Date?
    var sunsetTime: Date?
}

extension BlockDataDaily: CustomStringConvertible {
    var description: String {
        return "The temperature: " + String(describing: temperature) +
            "\nThe Max Temperature: " + String(describing: temperatureMax) +
            "\n The min Temperature" + String(describing: temperatureMin) + "\n"
    }
    
}
