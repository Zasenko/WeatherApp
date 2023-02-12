//
//  CityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import Foundation

protocol CityPresenterProtocol: AnyObject {
   // var city: CityModel { get set }
    func getHourlyWeatherCount() -> Int
    func getDailyWeatherCount() -> Int
    func getHourlyWeather(cell row: Int) -> HourCellModel?
    func getDailyWeather(cell row: Int) -> DayCellModel?
    func getWeatherInfo()
}

final class CityPresenter {
    
    // MARK: - Properties
    
    weak var view: CityViewProtocol?
    var city: CityModel
    
    // MARK: - Private properties
    
    private let router: CitiesRouterProtocol
    private let networkManager: WeatherNetworkManagerProtocol
    private let dateFormatter: DateFormatterManagerProtocol
    
    // MARK: - Inits
    
    init(view: CityViewProtocol, router: CitiesRouterProtocol, networkManager: WeatherNetworkManagerProtocol, city: CityModel, dateFormatter: DateFormatterManagerProtocol) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.city = city
        self.dateFormatter = dateFormatter
    }
}

// MARK: CityPresenterProtocol

extension CityPresenter: CityPresenterProtocol {
    
    func getHourlyWeatherCount() -> Int {
        return city.weather.hourly?.weathers.count ?? 0
    }
    
    func getDailyWeatherCount() -> Int {
        return city.weather.daily?.weathers.count ?? 0
    }
    
    func getHourlyWeather(cell row: Int) -> HourCellModel? {
        guard let hourWeather = city.weather.hourly?.weathers[row] else { return nil }
        var time = ""
        var temperature = ""
        switch hourWeather.type {
        case .weather:
            time = dateFormatter.hourFormat.string(from: hourWeather.time)
            temperature = "\(hourWeather.temperature > 0 ? "+" : "")\(hourWeather.temperature)°"
        case .sunrise:
            time = dateFormatter.hourAndMinFormat.string(from: hourWeather.time)
            temperature = "sunrise"
        case .sunset:
            time = dateFormatter.hourAndMinFormat.string(from: hourWeather.time)
            temperature = "sunset"
        }
        return HourCellModel(hour: time, img: hourWeather.weathercode.image, temp: temperature)
    }
    
    func getDailyWeather(cell row: Int) -> DayCellModel? {
        guard let dayWeather = city.weather.daily?.weathers[row] else { return nil }
        let date = dateFormatter.dayCellFormat.string(from: dayWeather.date)
        let tempMin = "\(dayWeather.temperatureMin > 0 ? "+" : "")\(dayWeather.temperatureMin)° ... "
        let tempMax = "\(dayWeather.temperatureMax > 0 ? "+" : "")\(dayWeather.temperatureMax)°"
        let sunsetString = dateFormatter.hourAndMinFormat.string(from: dayWeather.sunset)
        let sunriseString = dateFormatter.hourAndMinFormat.string(from: dayWeather.sunrise)
        return DayCellModel(date: date, img: dayWeather.weathercode.image, tempMin: tempMin, tempMax: tempMax, sunrise: sunriseString, sunset: sunsetString)
    }
    func getWeatherInfo() {
        networkManager.fetchWeatherByLocation(latitude: String(city.latitude), longitude: String(city.longitude)) { [weak self] result in
                        guard let self = self else { return }
            DispatchQueue.main.sync {
                switch result {
                case .success(let weather):
                    if self.city.changeData(currentWeather: weather.currentWeather, hourlyWeather: weather.hourly, dailyWeather: weather.daily, dateFormatter: self.dateFormatter) {
                        guard let currentWeather = self.city.weather.currentWeather else { return }
                        self.view?.reloadCity(img: currentWeather.weathercode.image, temp: "\(currentWeather.temperature > 0 ? "+" : "")\(currentWeather.temperature)°")
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
}
