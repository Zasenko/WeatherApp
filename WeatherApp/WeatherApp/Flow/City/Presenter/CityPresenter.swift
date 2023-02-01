//
//  CityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import Foundation

protocol CityPresenterProtocol: AnyObject {
    var city: CityModel { get set }
    func getHourlyWeatherCount() -> Int
    func getDailyWeatherCount() -> Int
    func getWeatherInfo()
}

final class CityPresenter {
    
    // MARK: - Properties
    
    weak var view: CityViewProtocol?
    var city: CityModel
    
     private let dateFormatter = DateFormatter()
    
    // MARK: - Private properties
    
    private let router: CitiesRouterProtocol?
    private let networkManager: WeatherNetworkManagerProtocol?
    
    // MARK: - Inits
    
    init(router: CitiesRouterProtocol?, networkManager: WeatherNetworkManagerProtocol?, city: CityModel) {
        self.router = router
        self.networkManager = networkManager
        self.city = city
    }
}

extension CityPresenter {
    
    // MARK: Functions
    
    func getHourlyWeatherCount() -> Int {
        return city.hourly?.temperature.count ?? 0
    }
    
    func getDailyWeatherCount() -> Int {
        return city.daily?.temperatureMax.count ?? 0
    }
    
    // MARK: Private functions
    
    func getWeatherInfo() {
        networkManager?.fetchWeatherByLocation(latitude: String(city.coordinate.latitude), longitude: String(city.coordinate.longitude), complition: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                switch result {
                case .success(let weather):
                    if self.city.changeData(currentWeather: weather.currentWeather, hourly: weather.hourly, daily: weather.daily, dateFormatter: self.dateFormatter) {
                        self.view?.reloadCity()
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        })
    }
}

extension CityPresenter: CityPresenterProtocol {
    
}
