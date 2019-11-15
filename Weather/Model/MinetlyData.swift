//
//  MinetlyData.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

struct MinetlyData: Decodable {
    var precipIntensity: Double?
    var precipProbability: Double?
    var time: Date?
}
