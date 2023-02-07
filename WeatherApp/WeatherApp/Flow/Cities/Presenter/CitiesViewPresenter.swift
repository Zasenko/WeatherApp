//
//  CitiesViewPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import Foundation

protocol CitiesViewProtocol: AnyObject {
    func reloadTableView()
}

protocol CitiesViewPresenterProtocol: AnyObject {
    func cellTaped(indexPath: IndexPath)
    func addButtonTapped()
    func addNewCity(city: CityModel)
    func getCitiesCount() -> Int
    func getCity(indexPath: Int) -> CityModel
}

protocol CitiesViewPresenterDelegate: AnyObject {
    func addCity()//(city: CityModel)
}

final class CitiesViewPresenter {
    
    // MARK: - Properties

    weak var view: CitiesViewProtocol?
    private var cities: [CityModel] = []
    
    // MARK: - Private properties
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let router: CitiesRouterProtocol
    private let dateFormatter: DateFormatterManagerProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, networkManager: WeatherNetworkManagerProtocol, dateFormatter: DateFormatterManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.router = router
        self.networkManager = networkManager
        self.dateFormatter = dateFormatter
        self.coreDataManager = coreDataManager
        let a = coreDataManager.getCities()
        cities = a.map({ CityModel(latitude: $0.latitude, longitude: $0.longitude, name: $0.name, country: $0.country, weather: WeatherModel()) })
    }
}

// MARK: - CitiesViewPresenterProtocol

extension CitiesViewPresenter: CitiesViewPresenterProtocol {
    func getCitiesCount() -> Int {
        return coreDataManager.cities.count
    }
    
    func getCity(indexPath: Int) -> CityModel {
        let a = coreDataManager.cities[indexPath]
        return CityModel(latitude: a.latitude, longitude: a.longitude, name: a.name, country: a.country, weather: WeatherModel())
    }

    func cellTaped(indexPath: IndexPath) {
        router.showCityViewController(city: cities[indexPath.row])
    }
    
    func addButtonTapped() {
        router.showAddCityViewController(delegate: self)
    }
    
    func addNewCity(city: CityModel) {
        cities.append(city)
        view?.reloadTableView()
    }
}

// MARK: - CitiesViewPresenterDelegate

extension CitiesViewPresenter: CitiesViewPresenterDelegate {
    func addCity() {
        view?.reloadTableView()
    }
    
//    func addCity(city: CityModel) {
//        addedCity(city: city)
//    }
}

// MARK: - Private functions

extension CitiesViewPresenter {
    
    private func addedCity(city: CityModel) {
                var city = city
                networkManager.fetchCurrentWeatherByLocation(latitude: String(city.latitude), longitude: String(city.longitude), complition: { [weak self] result in
                    guard let self = self else {return}
        
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let location):
                            if let currentWeathe = location.currentWeather {
                                if city.changeData(currentWeather: currentWeathe, hourlyWeather: nil, dailyWeather: nil, dateFormatter: self.dateFormatter) {
                                    self.cities.append(city)
                                }
                            }
                            self.view?.reloadTableView()
                        case .failure(let error):
                            print(error)
                        }
                    }
                })
    }
}
