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
    func getLocation()
}

class WeatherPresenter {
    
    weak var view: WeatherViewProtocol?
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let geoCoder: GeoCodingManagerProtocol
    private var locationManager: LocationManagerProtocol
    
    private var place: CityModel?
    private let dateFormatter = DateFormatter()
    
    init(networkManager: WeatherNetworkManagerProtocol, geoCoder: GeoCodingManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManager = networkManager
        self.geoCoder = geoCoder
        self.locationManager = locationManager
        self.locationManager.callBack = { [weak self] result in
            guard let self = self else { return }
            self.getLocationInfo(coordinate: result)
        }
    }
    
}

extension WeatherPresenter: WeatherPresenterProtocol {
    func getLocation() {
        getCoordinate()
    }
}

// MARK: - Private functions

extension WeatherPresenter {
    
    private func getCoordinate() {
        locationManager.getUserLocation()
    }
    
    private func getLocationInfo(coordinate: CLLocation) {
        geoCoder.findCity(coordinate: coordinate) { [weak self] place in
            guard let self = self, let place = place else { return }
            self.place = place
            self.view?.changeLocation(place: place)
            self.networkManager.fetchFullWeatherByLocation(latitude: String(place.coordinate.latitude),
                                                           longitude: String(place.coordinate.longitude)) { [weak self] result in
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weather):
                        guard let place = self.place else { return }
                        if place.weather.changeData(currentWeather: weather.currentWeather, hourlyWeather: weather.hourly, dailyWeather: weather.daily, dateFormatter: self.dateFormatter) {
                            
                            self.view?.changeWeather(place: place)
                        }
                    case .failure(let error):
                        debugPrint(error)
                    }
                }
                
            }
        }
    }
}
