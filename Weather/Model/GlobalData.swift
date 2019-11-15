//
//  GlobalData.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

class GlobalData: Decodable {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var currently: BlockData
    var hourly: DataFrame?
    var daily: DataFrameDaily?
    var minutely: DataFrameMinutely?
    
}

class DataFrameMinutely: Decodable {
    var data: [MinetlyData]?
    var icon: String?
    var summary: String?
}

class DataFrameDaily: Decodable {
    var data: [BlockDataDaily]?
}

class DataFrame:  Decodable{
    var data: [BlockData]?
    var summary: String?
}
