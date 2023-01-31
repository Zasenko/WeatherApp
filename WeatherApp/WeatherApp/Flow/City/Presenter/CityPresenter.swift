//
//  CityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import Foundation

class DateFormatterVK {
    
    let dateFormatter = DateFormatter()
    
    func convertDate(timeIntervalSince1970: Double) -> String {
        dateFormatter.dateFormat = "dd-MM-yyyy HH.mm"
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        return dateFormatter.string(from: date)
    }
}


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
    
    private let dateFor = DateFormatter()
    
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
                    
                    // TODO !!!!!! модель данных
                    var weatherCodeArray: [WeatherCodes] = []
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
                            weatherCodeArray.append(weatherCode)
                        }
                    }
                    
                    var timesArray: [Date] = []
                    if let times = weather.hourly?.time {
                        for time in times {
                            self.dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm"
                            if let yourDate: Date = self.dateFor.date(from: time) {
                                timesArray.append(yourDate)
                            }
                        }
                    }
                    
                    let temperature = weather.hourly?.temperature
                    let hourlyWeather = HourlyWeatherModel(time: timesArray, temperature: temperature ?? [], weathercode: weatherCodeArray)
                    
                    
                    self.city.hourly = hourlyWeather
                    
                    var weatherCDArray: [WeatherCodes] = []
                    if let intArray = weather.daily?.weathercode {
                        for int in intArray {
                            var weatherCode: WeatherCodes {
                                switch int {
                                case 0:
                                    return .clearSky
                                case 1, 2:
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
                            weatherCDArray.append(weatherCode)
                        }
                    }
                    
                    var dates: [Date] = []
                    if let datesString = weather.daily?.time {
                        for date in datesString {
                            self.dateFor.dateFormat = "MM-dd"
                            if let yourDate = self.dateFor.date(from: date) {
                                dates.append(yourDate)
                            }
                        }
                    }
                    
                    self.dateFor.dateFormat = "MM-dd"
                    self.city.daily?.sunset = weather.daily?.sunset?.map( { self.dateFor.date(from: $0) }) as! [Date]
                    print(self.city.daily?.sunset ?? "----------")
                    print("----------")
                    self.city.daily?.sunrise = weather.daily?.sunrise?.compactMap( { self.dateFor.date(from: $0) }) ?? []
                    print(self.city.daily?.sunrise ?? "----------")
                    
                    self.city.daily?.temperatureMax = weather.daily?.temperatureMax ?? []
                    self.city.daily?.temperatureMin = weather.daily?.temperatureMin ?? []
                    
                    self.city.daily = DailyWeatherModel(time: dates, weathercode: weatherCDArray, temperatureMax: self.city.daily?.temperatureMax ?? [], temperatureMin: self.city.daily?.temperatureMin ?? [], sunrise: self.city.daily?.sunrise ?? [], sunset: self.city.daily?.sunset ?? [])
                    
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
