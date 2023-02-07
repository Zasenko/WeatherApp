//
//  WeathersModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 02.02.23.
//

import Foundation

struct WeathersModel {
    var currentWeather: CurrentWeather?
    var hourly: HourlyWeather?
    var daily: DailyWeather?
}

struct CurrentWeather {
    var temperature: Double
    var weathercode: WeatherCodes
    var time: Date
}

struct HourlyWeather {
    var weathers: [HourWeather]
}

struct HourWeather {
    let time: Date
    let temperature: Double
    let weathercode: WeatherCodes
    let type: HourWeatherType
}

enum HourWeatherType {
    case weather, sunrise, sunset
}


struct DailyWeather {
    var weathers: [DayWeather]
}

struct DayWeather {
    let date: Date
    var weathercode: WeatherCodes
    var temperatureMax: Double
    var temperatureMin: Double
    var sunrise: Date
    var sunset: Date
}
