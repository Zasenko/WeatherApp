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
    func getWeatherInfo()
}

final class CityPresenter {
    
    // MARK: - Properties
    
    weak var view: CityViewProtocol?
    var city: CityModel
    
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
        return city.hourly?.temperature?.count ?? 0
    }
    
    // MARK: Private functions
    
    func getWeatherInfo() {
        networkManager?.fetchWeatherByLocation(latitude: String(city.coordinate.latitude), longitude: String(city.coordinate.longitude), complition: { [weak self] result in
                     guard let self = self else { return }
            DispatchQueue.main.sync {
                switch result {
                case .success(let weather):
                    print("--------------")
                    print(weather)
                    // TODO !!!!!! модель данных
                    var weatherCodeArray: [WeatherCodes]?
                    if let intArray = weather.hourly?.weathercode {
                        for int in intArray {
                            var weatherCode: WeatherCodes {
                                switch int {
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
                            weatherCodeArray?.append(weatherCode)
                        }
                    }
                    
                    let time = weather.hourly?.time
                    let temperature = weather.hourly?.temperature
                    let hourlyWeather = HourlyWeatherModel(time: time, temperature: temperature, weathercode: weatherCodeArray)
                    self.city.hourly = hourlyWeather
                    //                    self.city.hourly?.time = weather.hourly?.time ?? nil
                    //                    self.city.hourly?.temperature = weather.hourly?.temperature ?? nil
                    
                    self.city.daily?.temperatureMax = weather.daily?.temperatureMax ?? nil
                    self.city.daily?.temperatureMax = weather.daily?.temperatureMax ?? nil
                    self.city.daily?.weathercode = weather.daily?.weathercode ?? nil
                    self.city.daily?.time = weather.daily?.time ?? nil
                    self.city.daily?.sunset = weather.daily?.sunset ?? nil
                    self.city.daily?.sunrise = weather.daily?.sunrise ?? nil
                    print("-----------")
                    print(self.city)
                    self.view?.reloadCity()
                case .failure(let error):
                    debugPrint(error)
                }
            }
        })
    }
}

extension CityPresenter: CityPresenterProtocol {
    
}
