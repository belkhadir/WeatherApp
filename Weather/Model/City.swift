//
//  City.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import CoreData


final class City: NSManagedObject{
    
    // Mark: - Instance Properties
    @NSManaged var name: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    
    @NSManaged var temperature: Double
    @NSManaged var summary: String
    @NSManaged var imageName: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
    
    // Mark: - Object Life cycle
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(name: String, latitude: Double = 0.0,
         longitude: Double = 0.0, temperature: Double = 14,
        summary: String = "", icon: String = "", insertInto context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)
        super.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
        self.summary = summary
        self.imageName = icon
    }
}
