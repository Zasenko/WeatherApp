//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 01.02.23.
//

import Foundation
import CoreLocation

protocol WeatherViewProtocol: AnyObject {
    func changeLocation(place: CityModel)
    func changeWeather(place: CityModel)
}

protocol WeatherPresenterProtocol: AnyObject {
    func getWeather()
    func getHourlyWeatherCount() -> Int
    func getDailyWeatherCount() -> Int
    func getHourlyWeather(cell row: Int) -> HourWeather?
    func getDailyWeather(cell row: Int) -> DayWeather?
}

class WeatherPresenter {
    
    // MARK: - Properties
    
    weak var view: WeatherViewProtocol?
    
    // MARK: - Private properties
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let geoCoder: GeoCodingManagerProtocol
    private var locationManager: LocationManagerProtocol
    
    private var place: CityModel?
    private let dateFormatter = DateFormatter()
    
    // MARK: - Inits
    
    init(networkManager: WeatherNetworkManagerProtocol, geoCoder: GeoCodingManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManager = networkManager
        self.geoCoder = geoCoder
        self.locationManager = locationManager
        self.locationManager.delegate = self
    }
}

// MARK: - WeatherPresenterProtocol

extension WeatherPresenter: WeatherPresenterProtocol {
    func getWeather() {
        getCoordinate()
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
    func reloadUserLocation(location: CLLocation) {
        getLocationInfo(coordinate: location)
    }
}

// MARK: - Private functions

extension WeatherPresenter {
    
    private func getCoordinate() {
        locationManager.getUserLocation()
    }
    
    private func getLocationInfo(coordinate: CLLocation) {
        geoCoder.findCity(coordinate: coordinate) { [weak self] result in
            guard let self = self else { return}
            DispatchQueue.main.async {
                switch result {
                case.success(let place):
                    self.place = place
                    self.view?.changeLocation(place: place)
                    self.getWeather(coordinate: place.coordinate)
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getWeather(coordinate: CLLocationCoordinate2D) {
        
        let latitude = String(coordinate.latitude)
        let longitude = String(coordinate.longitude)
        
        guard var place = self.place else { return }
        
        networkManager.fetchFullWeatherByLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            guard let self = self else { return}
                switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        if place.weather.changeData(currentWeather: weather.currentWeather, hourlyWeather: weather.hourly, dailyWeather: weather.daily, dateFormatter: self.dateFormatter) {
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
