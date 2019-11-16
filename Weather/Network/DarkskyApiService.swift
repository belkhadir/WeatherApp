//
//  DarkskyApiService.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

class DarkskyApiService {
    
    static func forecast(city: CityModelView, completion: @escaping (Result<GlobalData, DataResponseError>) -> Void) {
        let query  = [URLQueryItem(name: "exclude", value: "hourly")]
        var path = "/forecast/" + API_SECRET_WEATHER
        path.append("/\(city.latitude),\(city.longitude)")
        request(for: GlobalData.self, host: "api.darksky.net", path: path, query: query, method: HTTPMethod.get) {completion($0)}
    }
    
    static func forecast(latitude: Double, longitude: Double, completion: @escaping (Result<GlobalData, DataResponseError>) -> Void) {
        let query  = [URLQueryItem(name: "exclude", value: "hourly")]
        var path = "/forecast/" + API_SECRET_WEATHER
        path.append("/\(latitude),\(longitude)")
        request(for: GlobalData.self, host: "api.darksky.net", path: path, query: query, method: HTTPMethod.get) {completion($0)}
    }
}
