//
//  CityModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 27.01.23.
//

import Foundation

struct CityModel {
    let latitude: Double
    let longitude: Double
    let name: String
    let country: String
    var lastUpdate: Date?
    var weather: WeathersModel

    mutating func changeData(currentWeather: CurentWeatherModel?, hourlyWeather: HourlyWeatherDecodedModel?, dailyWeather: DailyWeatherDecidedModel?, dateFormatter: DateFormatterManagerProtocol) -> Bool {
        
        if let currentWeather = currentWeather,
           let time = dateFormatter.fullFormat.date(from: currentWeather.time) {
            print(time)
            weather.currentWeather = CurrentWeather(temperature: currentWeather.temperature,
                                                    weathercode: changeCode(weathercode: currentWeather.weathercode),
                                                    time: time)
        }
        
        if let hourlyWeatehr = hourlyWeather {
            let times = hourlyWeatehr.time.map({dateFormatter.fullFormat.date(from: $0)})
            let temperatures = hourlyWeatehr.temperature
            let weathercodes = changeCodes(weathercodes: hourlyWeatehr.weathercode)
            
            var weathers = [HourWeather]()
            for (time, temperature, weathercode) in zip3(times, temperatures, weathercodes) {
                if let time = time {
                    let hourWeather = HourWeather(time: time, temperature: temperature, weathercode: weathercode, type: .weather)
                    weathers.append(hourWeather)
                }
            }
            
            if let time = weather.currentWeather?.time {
                print(time)
                weather.hourly = HourlyWeather(weathers: weathers.filter({$0.time > time}))
            }
        }
        
        if let dailyWeather = dailyWeather {
            let times = dailyWeather.time.map({dateFormatter.dayFormat.date(from: $0)})
            let weathercodes = changeCodes(weathercodes: dailyWeather.weathercode)
            let maxTemperatures = dailyWeather.temperatureMax
            let minTemperatures = dailyWeather.temperatureMin
            
            let sunrises = dailyWeather.sunrise.map( { dateFormatter.fullFormat.date(from: $0) } )
            let sunsets = dailyWeather.sunset.map( { dateFormatter.fullFormat.date(from: $0) } )
            
            var weathers = [DayWeather]()
            for (time, weathercode, maxTemperature, minTemperature, sunrise, sunset) in zip6(times, weathercodes, maxTemperatures, minTemperatures, sunrises, sunsets) {
                if let time = time,
                   let sunset = sunset,
                   let sunrise = sunrise {

                    weather.hourly?.weathers.append(HourWeather(time: sunset, temperature: 0, weathercode: .sunset, type: .sunset))
                    weather.hourly?.weathers.append(HourWeather(time: sunrise, temperature: 0, weathercode: .sunrise, type: .sunrise))
                    if let w = weather.hourly?.weathers.sorted(by: { $0.time < $1.time } ), let time = weather.currentWeather?.time {
                        print(time)
                        weather.hourly?.weathers = w.filter({$0.time > time})
                    }
                    let weather = DayWeather(date: time,
                                             weathercode: weathercode,
                                             temperatureMax: maxTemperature,
                                             temperatureMin: minTemperature,
                                             sunrise: sunrise,
                                             sunset: sunset)
                    weathers.append(weather)
                }
            }
            weather.daily = DailyWeather(weathers: weathers)
        }
        
        lastUpdate = .now
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


