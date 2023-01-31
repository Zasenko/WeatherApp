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
    
    mutating func changeData(currentWeather: Weather?, hourly: HourlyWeatherDecodedModel?, daily: DailyWeatherDecidedModel?, dateFormatter: DateFormatter) -> Bool {
        if let weather = currentWeather {
            self.currentWeather = CityWeather(temperature: weather.temperature, weathercode: changeCode(weathercode: weather.weathercode))
        }
        if let hourlyWeatehr = hourly {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let times = hourlyWeatehr.time.compactMap({dateFormatter.date(from: $0)})
            let temp = hourlyWeatehr.temperature
            let codes = changeCodes(weathercodes: hourlyWeatehr.weathercode)
            
            self.hourly = HourlyWeatherModel(time: times, temperature: temp, weathercode: codes)
        }
        if let daily = daily {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let times = daily.time.compactMap({dateFormatter.date(from: $0)})
            let weathercode = changeCodes(weathercodes: daily.weathercode)
            let temperatureMax = daily.temperatureMax
            let temperatureMin = daily.temperatureMin
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let sunrise = daily.sunrise.compactMap( { dateFormatter.date(from: $0) } )
            let sunset = daily.sunset.compactMap( { dateFormatter.date(from: $0) } )
            self.daily = DailyWeatherModel(time: times, weathercode: weathercode, temperatureMax: temperatureMax, temperatureMin: temperatureMin, sunrise: sunrise, sunset: sunset)
        }
        return true
    }
    
    private func changeCode(weathercode: Int) -> WeatherCodes {
            switch weathercode {
            case 0:
                return .clearSky
            case 2:
                return .partlyCloudy
            case 3:
                return .cloudy
            case 61, 63, 65, 80, 81, 82:
                return .rain
            case 71, 73, 75:
                return .snow
            default:
                return .unknown
            }
    }
    
    private func changeCodes(weathercodes: [Int]) -> [WeatherCodes] {
        var weatherCodes: [WeatherCodes] = []
        for int in weathercodes {
            
                switch int {
                case 0:
                    weatherCodes.append(.clearSky)
                case 2:
                    weatherCodes.append(.partlyCloudy)
                case 3:
                    weatherCodes.append(.cloudy)
                case 61, 63, 65, 80, 81, 82:
                    weatherCodes.append(.rain)
                case 71, 73, 75:
                    weatherCodes.append(.snow)
                default:
                    weatherCodes.append(.unknown)
                }
        }
        return weatherCodes
    }
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
    
