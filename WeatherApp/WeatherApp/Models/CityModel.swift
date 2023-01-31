//
//  CityModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 27.01.23.
//

import Foundation
import CoreLocation

struct CityModel {
    let coordinate: CLLocationCoordinate2D
    let name: String
    let country: String
    
    var currentWeather: CityWeather?
    var hourly: HourlyWeatherModel?
    var daily: DailyWeatherModel?
}

struct CityWeather {
    var temperature: Double
    var weathercode: WeatherCodes
}

struct HourlyWeatherModel {
    var time: [Date]
    var temperature: [Double]
    var weathercode: [WeatherCodes]
}

struct DailyWeatherModel {
    var time: [Date]
    var weathercode: [WeatherCodes]
    var temperatureMax: [Double]
    var temperatureMin: [Double]
    var sunrise: [Date]
    var sunset: [Date]
}

