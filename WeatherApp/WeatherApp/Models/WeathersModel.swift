//
//  WeathersModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 02.02.23.
//

import Foundation

struct WeathersModel {
    
    var currentWeather: CurrentWeather? = nil
    var hourly: HourlyWeather? = nil
    var daily: DailyWeather? = nil
    var lastUpdate: Date? = nil
    
    mutating func changeData(currentWeather: WeatherModel?, hourlyWeather: HourlyWeatherDecodedModel?, dailyWeather: DailyWeatherDecidedModel?, dateFormatter: DateFormatter) -> Bool {
        if let currentWeather = currentWeather {
            self.currentWeather = CurrentWeather(temperature: currentWeather.temperature, weathercode: changeCode(weathercode: currentWeather.weathercode))
        }
        
        if let hourlyWeatehr = hourlyWeather {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            
            let times = hourlyWeatehr.time.map({dateFormatter.date(from: $0)})
            let temperatures = hourlyWeatehr.temperature
            let weathercodes = changeCodes(weathercodes: hourlyWeatehr.weathercode)
            
            var weathers = [HourWeather]()
            for (time, temperature, weathercode) in zip3(times, temperatures, weathercodes) {
                if let time = time {
                    let hourWeather = HourWeather(time: time, temperature: temperature, weathercode: weathercode)
                    weathers.append(hourWeather)
                }
            }
            self.hourly = HourlyWeather(weathers: weathers.filter({$0.time >= .now}))
        }
        
        if let dailyWeather = dailyWeather {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let times = dailyWeather.time.map({dateFormatter.date(from: $0)})
            let weathercodes = changeCodes(weathercodes: dailyWeather.weathercode)
            let maxTemperatures = dailyWeather.temperatureMax
            let minTemperatures = dailyWeather.temperatureMin
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let sunrises = dailyWeather.sunrise.map( { dateFormatter.date(from: $0) } )
            let sunsets = dailyWeather.sunset.map( { dateFormatter.date(from: $0) } )
            
            var weathers = [DayWeather]()
            for (time, weathercode, maxTemperature, minTemperature, sunrise, sunset) in zip6(times, weathercodes, maxTemperatures, minTemperatures, sunrises, sunsets) {
                if let time = time, let sunset = sunset, let sunrise = sunrise {
                    let weather = DayWeather(date: time, weathercode: weathercode, temperatureMax: maxTemperature, temperatureMin: minTemperature, sunrise: sunrise , sunset: sunset)
                    weathers.append(weather)
                }
            }
            self.daily = DailyWeather(weathers: weathers)
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
            return .freezingRain
        case 71, 73, 75: //Snow fall: Slight, moderate, and heavy intensity
            return .snow
        case 77: //Snow grains / Снежные зерна
            return .snowGrains
        case 80, 81, 82: //Rain showers: Slight, moderate, and violent
            return .rain
        case 85, 86: //Snow showers slight and heavy / Снег слабый и сильный
            return .snowShowers
        case 95: //*    Thunderstorm: Slight or moderate / Гроза: Слабая или умеренная
            return .thunderstormSlightOrModerate
        case 96, 99: //*    Thunderstorm with slight and heavy hail // Гроза со слабым и сильным градом
            return .snow
        default: //(*) Thunderstorm forecast with hail is only available in Central Europe
            return .unknown
        }
    }
}

struct CurrentWeather {
    var temperature: Double
    var weathercode: WeatherCodes
}

struct HourlyWeather {
    var weathers: [HourWeather]
}

struct HourWeather {
    let time: Date
    var temperature: Double
    var weathercode: WeatherCodes
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
