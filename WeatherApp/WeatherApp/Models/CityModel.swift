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
    
    private func changeCodes(weathercodes: [Int]) -> [WeatherCodes] {
        var weatherCodes: [WeatherCodes] = []
        for int in weathercodes {
            let code = changeCode(weathercode: int)
            weatherCodes.append(code)
        }
        return weatherCodes
    }
    
    private func changeCode(weathercode: Int) -> WeatherCodes {
            switch weathercode {
            case 0:
                return .clearSky
            case 1: //Mainly clear
                return .mainlyClearSky
            case 2: //partly cloudy
                return .partlyCloudy
            case 3:// and overcast
                return .cloudy
            case 45, 48: //Fog and depositing rime fog
                return .fog
            case 51, 53, 55: // Drizzle: Light, moderate, and dense intensity
                return .drizzle
            case 56, 57: //    Freezing Drizzle: Light and dense intensity
                return .drizzle
            case 61, 63, 65: //Rain: Slight, moderate and heavy intensity
                return .rain
            case 66, 67: // Freezing Rain: Light and heavy intensity
                return .rain
            case 71, 73, 75: //Snow fall: Slight, moderate, and heavy intensity
                return .snow
            case 77: //Snow grains
                return .snow
            case 80, 81, 82: //Rain showers: Slight, moderate, and violent
                return .rain
            case 85, 86: //Snow showers slight and heavy
                return .snow
            case 95: //*    Thunderstorm: Slight or moderate
                return .snow
            case 96, 99: //*    Thunderstorm with slight and heavy hail
                return .snow
            default: //(*) Thunderstorm forecast with hail is only available in Central Europe
                return .unknown
            }
    }
}
///
///0 Чистое небо
///
///1, 2, 3 Преимущественно ясно, переменная облачность, пасмурно
///
///45, 48 Туман и изморозь тумана
///
///51, 53, 55 Морось: легкая, умеренная и густая интенсивность
///
///56, 57 Ледяная морось: Легкая и плотная интенсивность
///
///61, 63, 65 Дождь: слабый, умеренный и сильный
///
///66, 67 Ледяной дождь: легкая и сильная интенсивность
///
///71, 73, 75 Снегопад: легкий, умеренный и сильный
///77 Снежные зерна
///
///80, 81, 82 Ливневые дожди: слабые, умеренные и сильные
///
///85, 86 Снег слабый и сильный
///
///95 * Гроза: Слабая или умеренная
///
///96, 99 * Гроза со слабым и сильным градом
///
///(*) Прогноз грозы с градом доступен только в Центральной Европе
    
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
    
