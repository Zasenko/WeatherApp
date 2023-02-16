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

protocol CitiesViewPresenterProtocol  {
    func cellTaped(indexPath: IndexPath)
    func addButtonTapped()
    func getCitiesCount() -> Int
    func getCity(indexPath: Int) -> CityModel
    func deleteButtonTapped(indexPath: Int, complition: @escaping((Bool) -> Void))
}

final class CitiesViewPresenter {
    
    // MARK: - Properties

    weak var view: CitiesViewProtocol?
    private var cities: [CityModel] = []
    
    // MARK: - Private properties
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let router: CitiesRouterProtocol
    private let dateFormatter: DateFormatterManagerProtocol
    private var coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Inits
    
    init(view: CitiesViewProtocol, router: CitiesRouterProtocol, networkManager: WeatherNetworkManagerProtocol, dateFormatter: DateFormatterManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.dateFormatter = dateFormatter
        self.coreDataManager = coreDataManager
        
        let cityModels = coreDataManager.getCities().map({ CityModel(latitude: $0.latitude, longitude: $0.longitude, name: $0.name, country: $0.country, weather: WeatherModel()) })
        
        for city in cityModels {
            fetchCurrentWeatherByLocation(city: city)
        }
        
        self.coreDataManager.cityAdded = { [weak self] city in
            guard let self = self else { return }
            self.fetchCurrentWeatherByLocation(city: city)
        }
    }
}

// MARK: - CitiesViewPresenterProtocol

extension CitiesViewPresenter: CitiesViewPresenterProtocol {
    func deleteButtonTapped(indexPath: Int, complition: @escaping ((Bool) -> Void)) {
        coreDataManager.deleteCity(indexPath: indexPath) { [weak self] result in
            if result {
                self?.cities.remove(at: indexPath)
                complition(true)
            }
        }
    }
    
    func getCitiesCount() -> Int {
        return cities.count
    }
    
    func getCity(indexPath: Int) -> CityModel {
        return cities[indexPath]
    }

    func cellTaped(indexPath: IndexPath) {
        router.showCityViewController(city: cities[indexPath.row])
    }
    
    func addButtonTapped() {
        router.showAddCityViewController()
    }
}

// MARK: - Private functions

extension CitiesViewPresenter {
    private func fetchCurrentWeatherByLocation(city: CityModel) {
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
