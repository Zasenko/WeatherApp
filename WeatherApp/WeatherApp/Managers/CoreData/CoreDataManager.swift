//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 07.02.23.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    var cities: [City] {get set}
    var cityAdded: ((CityModel) -> Void)? { get set }
    
    func save (city: CityModel, complition: @escaping((Bool) -> Void))
    func getCities() -> [City]
    func deleteCity(indexPath: Int, complition: @escaping ((Bool) -> Void))

}

final class CoreDataManager {
    
    var cities = [City]()
    var cityAdded: ((CityModel) -> Void)?

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Unresolved error \(error), \(error.userInfo)")
                return
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.persistentContainer.viewContext
    
    init() {
        self.cities = getCities()
    }
}

// MARK: - CoreDataManagerProtocol

extension CoreDataManager: CoreDataManagerProtocol {
    
    func save(city: CityModel, complition: @escaping ((Bool) -> Void)) {
        let coreDataCity = makeCity(city: city)
        cities.append(coreDataCity)
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                cityAdded?(city)
                complition(true)
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
                complition(false)
            }
        }
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
    
    func deleteCity(indexPath: Int, complition: @escaping ((Bool) -> Void)) {
        managedContext.delete(cities[indexPath])
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                complition(true)
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
                complition(false)
            }
        }
    }
}

// MARK: - Private functions

extension CoreDataManager {
    
    private func makeCity(city model: CityModel) -> City {
        let city = City(context: managedContext)
        city.setValue(model.longitude, forKey: #keyPath(City.longitude))
        city.setValue(model.latitude, forKey: #keyPath(City.latitude))
        city.setValue(model.name, forKey: #keyPath(City.name))
        city.setValue(model.country, forKey: #keyPath(City.country))
        return city
    }
}
