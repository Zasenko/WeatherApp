//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 07.02.23.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var country: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String

}

extension City : Identifiable {

}
