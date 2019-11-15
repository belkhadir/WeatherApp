//
//  BlockData.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

class BlockData: Decodable {
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
}

extension BlockData: CustomStringConvertible {
    var description: String {
        return  "Temperature: " + String(describing: temperature) +
            "\n Icon" + String(describing: icon) + "\n Time: " + String(describing: time)
    }
}
