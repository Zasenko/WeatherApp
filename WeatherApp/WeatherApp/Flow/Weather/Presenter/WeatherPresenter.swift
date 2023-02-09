//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 01.02.23.
//

import Foundation

protocol WeatherViewProtocol: AnyObject {
    func reloadLocation(name: String)
    func changeWeather(place: CityModel)
    func setSaveButton(seved: Bool)
}

protocol WeatherPresenterProtocol: AnyObject {
    func getWeather()
    func getHourlyWeatherCount() -> Int
    func getDailyWeatherCount() -> Int
    func getHourlyWeather(cell row: Int) -> HourWeather?
    func getDailyWeather(cell row: Int) -> DayWeather?
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
    
    init(networkManager: WeatherNetworkManagerProtocol, geoCoder: GeoCodingManagerProtocol, locationManager: LocationManagerProtocol, dateFormatter: DateFormatterManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
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
        guard var place = place else { return }
        coreDataManager.save(city: place) { [weak self] result in
            guard let self = self else { return }
            if result {
                self.place?.isSaved = true
                self.view?.setSaveButton(seved: true)
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
    
    func getDailyWeather(cell row: Int) -> DayWeather? {
        return place?.weather.daily?.weathers[row]
    }
    
    func getHourlyWeather(cell row: Int) -> HourWeather? {
        return place?.weather.hourly?.weathers[row]
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
                    if self.coreDataManager.cities.first(where: {$0.name == place.name && $0.country == place.country}) != nil {
                        self.view?.setSaveButton(seved: true)
                    } else {
                        self.view?.setSaveButton(seved: false)
                    }
                    self.view?.reloadLocation(name: place.name)
                    self.getWeather(latitude: String(place.latitude), longitude: String(place.longitude))
                case.failure(let error):
                    print(error)
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
                            self.view?.changeWeather(place: place)
                        }
                    }
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
}
