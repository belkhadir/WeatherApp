//
//  NetworkHelper.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import Foundation

struct ForHTTPHeaderField {
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
}



enum RequestError: Error {
    case novalidURL(String?)
}

enum HTTPMethod: String{
    case post = "POST"
    case get = "GET"
}


let baseURL = ""

enum DataResponseError: Error {
    case network
    case decoding
    case dataDecodint(data: Data)
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        case .dataDecodint:
            return "DAATA"
        }
    }
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

func request<T: Decodable>(for type: T.Type,
                           host: String,
                           path: String,
                           query: [URLQueryItem],
                           method: HTTPMethod,
                           completion: @escaping (Result<T, DataResponseError>) -> Void) {
    
    var compenents = URLComponents()
    compenents.scheme = "https"
    compenents.host = host
    
    compenents.path = path
    
    compenents.queryItems = query
    
    guard let url = compenents.url else {
        completion(Result.failure(DataResponseError.decoding))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.addValue("application/json", forHTTPHeaderField: ForHTTPHeaderField.ContentType)
    request.addValue("application/json", forHTTPHeaderField: ForHTTPHeaderField .Accept)
        
        
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
        guard let jsonD = responseData else {
            completion(Result.failure(DataResponseError.decoding))
            return
        }
//        debugPrint(convertToDictionary(data: jsonD))
        do {
            let responseData = try JSONDecoder().decode(type.self, from: jsonD)
            print(responseData)
            completion(Result.success(responseData))
        } catch let error{
            debugPrint(error)
            
            completion(Result.failure(DataResponseError.dataDecodint(data: jsonD)))
        }
    }
    task.resume()
    
}

func convertToDictionary(data: Data) -> [String: Any]? {
    
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        print(error.localizedDescription)
    }
    
    return nil
}
