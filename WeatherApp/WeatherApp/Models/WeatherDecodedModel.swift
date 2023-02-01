//
//  WeatherDecodedModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 01.02.23.
//

import Foundation

struct WeatherDecodedModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        case hourly, daily
    }
    
    var currentWeather: Weather?
    var hourly: HourlyWeatherDecodedModel?
    var daily: DailyWeatherDecidedModel?
}

struct Weather: Codable {
    let temperature: Double
    let weathercode: Int
}

struct HourlyWeatherDecodedModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weathercode
    }
    
    var time: [String]
    var temperature: [Double]
    var weathercode: [Int]
}

struct DailyWeatherDecidedModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case time
        case weathercode
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    var time: [String]
    var weathercode: [Int]
    var temperatureMax: [Double]
    var temperatureMin: [Double]
    var sunrise: [String]
    var sunset: [String]
}
