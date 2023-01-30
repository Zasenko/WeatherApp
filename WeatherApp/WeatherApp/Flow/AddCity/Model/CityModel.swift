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
    var temperature: Double?
    var weathercode: WeatherCodes?
}

struct HourlyWeatherModel {
    var time: [String]?
    var temperature: [Double]?
    var weathercode: [WeatherCodes]?
}

struct DailyWeatherModel {

    var time: [String]?
    var weathercode: [Int]?
    var temperatureMax: [Double]?
    var temperatureMin: [Double]?
    var sunrise: [String]?
    var sunset: [String]?
}

