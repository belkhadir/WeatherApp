//
//  ImageFactory.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

enum ImageFacotory: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case thunderstorm
    
    var images: [UIImage]  {
        var name: String = ""
        switch self {
        case .clearDay: name = "clear"
        case .clearNight: name = "clear_night"
        case .rain: name = "rain"
        case .snow: name = "snow"
        case .sleet: name = "hazy"
        case .wind: name = "hazy"
        case .fog: name = "hazy"
        case .cloudy: name = "brokenclouds_day"
        case .partlyCloudyDay: name = "fewclouds_day"
        case .partlyCloudyNight: name = "fewclouds_night"
        case .thunderstorm: name = "thunderstorm"
        }
        
        return (0...39).map { number in
            var newString = ""
            if number < 10 {
                newString = "0\(number)"
            }else {
                newString = "\(number)"
            }
            let imageName = "ani_icon_\(name)_\(newString)"
            return UIImage(named: imageName)!
        }
    }
    
    var backgroundImage: UIImage {
        var name: String = ""
        switch self {
        case .clearDay: name = "sunny"
        case .clearNight: name = "sunny_n"
        case .rain: name = "rain"
        case .snow: name = "snow"
        case .sleet: name = "hazy"
        case .wind: name = "hazy"
        case .fog: name = "fog"
        case .cloudy: name = "cloudy"
        case .partlyCloudyDay: name = "few_cloud"
        case .partlyCloudyNight: name = "few_cloud_n"
        case .thunderstorm: name = "thunderstorm"
        }
        
        let imageName = "vegoo_bg_\(name)"
        return UIImage(named: imageName)!
    }
    
    init?(string: String) {
        self.init(rawValue: string)
    }
}


