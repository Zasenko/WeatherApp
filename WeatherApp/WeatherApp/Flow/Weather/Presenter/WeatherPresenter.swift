//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 01.02.23.
//

import Foundation

protocol WeatherPresenterProtocol: AnyObject {
    func getWeather()
    func getHourlyWeatherCount() -> Int
    func getDailyWeatherCount() -> Int
    func getHourlyWeather(cell row: Int) -> HourCellModel?
    func getDailyWeather(cell row: Int) -> DayCellModel?
    func saveButtonTouched()
}

final class WeatherPresenter {
    
    // MARK: - Properties
    
    weak var view: WeatherViewProtocol?
    
    // MARK: - Private properties
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let geoCoder: GeoCodingManagerProtocol
    private var locationManager: LocationManagerProtocol
    private let dateFormatter: DateFormatterManagerProtocol
    private var coreDataManager: CoreDataManagerProtocol
    private var place: CityModel?
    
    // MARK: - Inits
    
    init(view: WeatherViewProtocol, networkManager: WeatherNetworkManagerProtocol, geoCoder: GeoCodingManagerProtocol, locationManager: LocationManagerProtocol, dateFormatter: DateFormatterManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.geoCoder = geoCoder
        self.locationManager = locationManager
        self.dateFormatter = dateFormatter
        self.coreDataManager = coreDataManager
        self.locationManager.delegate = self
    }
}

// MARK: - WeatherPresenterProtocol

extension WeatherPresenter: WeatherPresenterProtocol {
    func saveButtonTouched() {
        guard let place = place else { return }
        coreDataManager.save(city: place) { [weak self] result in
            guard let self = self else { return }
            if result {
                self.place?.isSaved = true
                self.view?.setSavedButton()
            } else {
                return
            }
        }
    }
    
    func getWeather() {
        getUserCoordinate()
    }
    
    func getDailyWeatherCount() -> Int {
        return place?.weather.daily?.weathers.count ?? 0
    }
    
    func getHourlyWeatherCount() -> Int {
        return place?.weather.hourly?.weathers.count ?? 0
    }
    
    func getHourlyWeather(cell row: Int) -> HourCellModel? {
        guard let hourWeather = place?.weather.hourly?.weathers[row] else { return nil }
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
        guard let dayWeather = place?.weather.daily?.weathers[row] else { return nil }
        
        
        let date = dateFormatter.dayCellFormat.string(from: dayWeather.date)
        let tempMin = "\(dayWeather.temperatureMin > 0 ? "+" : "")\(dayWeather.temperatureMin)° ... "
        let tempMax = "\(dayWeather.temperatureMax > 0 ? "+" : "")\(dayWeather.temperatureMax)°"
        let sunsetString = dateFormatter.hourAndMinFormat.string(from: dayWeather.sunset)
        let sunriseString = dateFormatter.hourAndMinFormat.string(from: dayWeather.sunrise)
        return DayCellModel(date: date, img: dayWeather.weathercode.image, tempMin: tempMin, tempMax: tempMax, sunrise: sunriseString, sunset: sunsetString)
    }
}

// MARK: - LocationManagerDelegate

extension WeatherPresenter: LocationManagerDelegate {
    func reloadUserLocation(latitude: Double, longitude: Double) {
        getLocationInfo(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Private functions

extension WeatherPresenter {
    
    private func getUserCoordinate() {
        locationManager.getUserLocation()
    }
    
    private func getLocationInfo(latitude: Double, longitude: Double) {
        geoCoder.findCity(latitude: latitude, longitude: longitude) { [weak self] result in
            guard let self = self else { return}
            DispatchQueue.main.async {
                switch result {
                case.success(let place):
                    self.place = place
                    self.view?.reloadLocationName(name: place.name)
                    self.getWeather(latitude: String(place.latitude), longitude: String(place.longitude))
                    if self.coreDataManager.cities.first(where: {$0.name == place.name && $0.country == place.country}) == nil {
                        self.view?.setSaveButton()
                    }
                case.failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    private func getWeather(latitude: String, longitude: String) {
        guard var place = self.place else { return }
        networkManager.fetchFullWeatherByLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            guard let self = self else { return}
                switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        if place.changeData(currentWeather: weather.currentWeather, hourlyWeather: weather.hourly, dailyWeather: weather.daily, dateFormatter: self.dateFormatter) {
                            self.place = place
                            guard let currentWeather = place.weather.currentWeather else {return}
                            self.view?.changeWeather(img: currentWeather.weathercode.image , temp: "\(currentWeather.temperature > 0 ? "+" : "")\(currentWeather.temperature)°")
                        }
                    }
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
}
