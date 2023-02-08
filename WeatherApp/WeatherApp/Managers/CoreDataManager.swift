//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 07.02.23.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var cities: [City] {get set}
    func save (complition: @escaping((Bool) -> Void))
    func makeCity(city model: CityModel) -> City
    func getCities() -> [City]
}

final class CoreDataManager: CoreDataManagerProtocol {
    

    var cities = [City]()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.persistentContainer.viewContext
    
    init() {
        self.cities = getCities()
    }
    
    // MARK: - Core Data Saving support
    func save(complition: @escaping ((Bool) -> Void)) {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                complition(true)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
                complition(false)
            }
        }
    }
    
    func makeCity(city model: CityModel) -> City {
        let city = City(context: managedContext)
        city.setValue(model.longitude, forKey: #keyPath(City.longitude))
        city.setValue(model.latitude, forKey: #keyPath(City.latitude))
        city.setValue(model.name, forKey: #keyPath(City.name))
        city.setValue(model.country, forKey: #keyPath(City.country))
        return city
    }
    
    func getCities() -> [City] {
      let request: NSFetchRequest<City> = City.fetchRequest()
      var fetchedCities: [City] = []
      do {
          fetchedCities = try managedContext.fetch(request)
      } catch let error {
         print("Error fetching singers \(error)")
      }
      return fetchedCities
    }
    
    func deleteCity(city: City) {
      let context = managedContext
      context.delete(city)
        save { [weak self] bool in
            print(bool)
        }
    }
}
