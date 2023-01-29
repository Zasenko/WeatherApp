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
    var cities: [CityModel] { get set }
    func cellTaped(name: String)
    func addButtonTapped()
    func addNewCity(city: GeoCodingCityModel)
}

protocol CitiesViewPresenterDelegate: AnyObject {
    func addCity(city: CityModel)
}

final class CitiesViewPresenter {
    
    // MARK: - Properties

    weak var view: CitiesViewProtocol?
    var cities: [CityModel] = []
    
    // MARK: - Private properties
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let router: CitiesRouterProtocol?
    
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, networkManager: WeatherNetworkManagerProtocol) {
        self.router = router
        self.networkManager = networkManager
    }
}

extension CitiesViewPresenter {
    
    private func addedCity(city: CityModel) {
                var city = city
                networkManager.fetchCurrentWeatherByLocation(latitude: String(city.coordinate.latitude), longitude: String(city.coordinate.longitude), complition: { [weak self] result in
                    guard let self = self else {return}
        
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let location):
                            if let currentWeathe = location.currentWeather {
                                var weatherCode: WeatherCodes {
                                    switch currentWeathe.weathercode {
                                    case 0:
                                        return .clearSky
                                    case 2:
                                        return .partlyCloudy
                                    case 3:
                                        return .cloudy
                                    case 61, 63, 65, 80, 81, 82:
                                        return .rain
                                    case 71, 73, 75:
                                        return .snow
                                    default:
                                        return .unknown
                                    }
                                }
                                let cityWeather = CityWeather(temperature: currentWeathe.temperature, weathercode: weatherCode)
                                city.currentWeather = cityWeather
                            }
                            self.cities.append(city)
                            self.view?.reloadTableView()
                        case .failure(let error):
                            print(error)
                        }
                    }
                })
    }
}

extension CitiesViewPresenter: CitiesViewPresenterDelegate {
    func addCity(city: CityModel) {
        addedCity(city: city)
    }
}

extension CitiesViewPresenter: CitiesViewPresenterProtocol {

    func cellTaped(name: String) {
        router?.showCityViewController(name: name)
    }
    
    func addButtonTapped() {
        router?.showAddCityViewController(delegate: self)
    }
    
    func addNewCity(city: GeoCodingCityModel) {
        cities.append(city)
        view?.reloadTableView()
    }
}
