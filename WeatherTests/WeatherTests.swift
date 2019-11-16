//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    var casa: City!
    var rabat: City!
    var fes: City!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        casa = City(name: "casablanca", latitude: 33.589886, longitude: -7.603869, temperature: 0, summary: "", icon: "")
        rabat = City(name: "rabat", latitude: 34.020882, longitude: -6.841650, temperature: 0, summary: "", icon: "")
        fes = City(name: "fes", latitude: 34.03715, longitude: -4.9998, temperature: 0, summary: "", icon: "")
        CityModelView.removeAllCities()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test_create_cities_model_view() {
        let cityModelView1 = CityModelView(city: casa)
        XCTAssertNotNil(cityModelView1)
        
        let cityModelView2 = CityModelView(city: rabat)
        XCTAssertNotNil(cityModelView2)
        
        let cityModelView3 = CityModelView(city: fes)
        XCTAssertNotNil(cityModelView3)

    }
    
    func test_no_cities() {
        let result = CityModelView.fetchAllCities()
        XCTAssert(result.count == 0)
    }
    

    func test_fetchAll_cities() {
        let cityModelView1 = CityModelView(city: casa)
        cityModelView1.saveCity()
        
        let cityModelView2 = CityModelView(city: rabat)
        cityModelView2.saveCity()
        
        let cityModelView3 = CityModelView(city: fes)
        cityModelView3.saveCity()
        let result = CityModelView.fetchAllCities()
        
        XCTAssert(result.count == 3)
    }
    
    func test_find_city() {
        
        let city = City(name: "CouCou", latitude: 1, longitude: 1, temperature: 1, summary: "", icon: "")
        
        
        let cityModelView = CityModelView(city: city)
        let newCity = cityModelView.findCityInCoreData()
        XCTAssert(newCity?.name == "CouCou")
        

        let noCity = CityModelView.find(city: "noCity")
        XCTAssertNil(noCity)
        
    }
    

    func test_modify_city() {
        
        let city = City(name: "CouCou", latitude: 1, longitude: 1, temperature: 1, summary: "", icon: "")
        let cityModelView = CityModelView(city: city)
        cityModelView.saveCity()
        
        cityModelView.name = "FouFou"
        
        cityModelView.saveCity()
        
        let newCity = cityModelView.findCityInCoreData()
        XCTAssert(newCity?.name == "FouFou")
    }
}
