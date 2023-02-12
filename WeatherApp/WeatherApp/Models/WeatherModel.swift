//
//  WeathersModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 02.02.23.
//

import Foundation

struct WeatherModel {
    var currentWeather: CurrentWeather?
    var hourly: HourlyWeather?
    var daily: DailyWeather?
}

struct CurrentWeather {
    var temperature: Double
    var weathercode: WeatherType
    var time: Date
}

struct HourlyWeather {
    var weathers: [HourWeather]
}

struct HourWeather {
    let time: Date
    let temperature: Double
    let weathercode: WeatherType
    let type: HourWeatherType
}

enum HourWeatherType: Int {
    case weather
    case sunrise
    case sunset
}


struct DailyWeather {
    var weathers: [DayWeather]
}

struct DayWeather {
    let date: Date
    var weathercode: WeatherType
    var temperatureMax: Double
    var temperatureMin: Double
    var sunrise: Date
    var sunset: Date
}
