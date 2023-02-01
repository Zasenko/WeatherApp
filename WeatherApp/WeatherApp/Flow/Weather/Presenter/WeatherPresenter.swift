//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 01.02.23.
//

import Foundation

protocol WeatherViewProtocol: AnyObject {
}

protocol WeatherPresenterProtocol: AnyObject {
    func getLocation()
}

class WeatherPresenter {
    
    weak var view: WeatherViewProtocol?
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let geoCoder: GeoCodingManagerProtocol
    
    private var place: CityModel?
    
    init(networkManager: WeatherNetworkManagerProtocol, geoCoder: GeoCodingManagerProtocol) {
        self.networkManager = networkManager
        self.geoCoder = geoCoder
    }
    
}

extension WeatherPresenter: WeatherPresenterProtocol {
    func getLocation() {
        getCoordinate()
        getLocationInfo()
        getWeather()
    }
}

extension WeatherPresenter {
    
    // MARK: - Private functions
    
    private func getCoordinate() {
        //
    }
    private func getLocationInfo() {
        //
    }
    private func getWeather() {
        //
    }
}
