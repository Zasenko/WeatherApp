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
    var cities: [GeoCodingCityModel] { get set }
    func cellTaped(name: String)
    func addButtonTapped()
    func addNewCity(city: GeoCodingCityModel)
}

final class CitiesViewPresenter {
    
    // MARK: - Properties
    
    let networkManager: WeatherNetworkManagerProtocol?
    let router: CitiesRouterProtocol?
    var cities: [GeoCodingCityModel] = []
    
    // MARK: - Private properties
    
    weak private var view: CitiesViewProtocol?
    
    // MARK: - Inits
    
    required init(view: CitiesViewProtocol, router: CitiesRouterProtocol, networkManager: WeatherNetworkManagerProtocol) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
    }
}

extension CitiesViewPresenter: CitiesViewPresenterProtocol {

    func cellTaped(name: String) {
        router?.showCityViewController(name: name)
    }
    
    func addButtonTapped() {
        router?.showAddCityViewController()
    }
    
    func addNewCity(city: GeoCodingCityModel) {
        
        var city = city
        
        networkManager?.fetchCurrentWeatherByLocation(latitude: String(city.coordinate.latitude), longitude: String(city.coordinate.longitude), complition: { [weak self] result in
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
                        var cityWeather = CityWeather(temperature: currentWeathe.temperature, weathercode: weatherCode)
                        city.currentWeather = cityWeather
                    }
                    
                    
                   // city.currentWeather = location.currentWeather
                    
                    
                    self.cities.append(city)
                    self.view?.reloadTableView()
                case .failure(let error):
                    print(error)
                }
            }
            
            
    
        })
    }
}
