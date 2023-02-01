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
    
    var weather: Weathers
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

struct Weathers {
    
    var currentWeather: CurrentWeather? = nil
    var hourly: HourlyWeather? = nil
    var daily: DailyWeather? = nil
    
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
            self.hourly = HourlyWeather(weathers: weathers)
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

struct Zip6Sequence<E1, E2, E3, E4, E5, E6>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3, E4, E5, E6)?
    
    init<S1: Sequence,
         S2: Sequence,
         S3: Sequence,
         S4: Sequence,
         S5: Sequence,
         S6: Sequence>(_ s1: S1,
                       _ s2: S2,
                       _ s3: S3,
                       _ s4: S4,
                       _ s5: S5,
                       _ s6: S6) where S1.Element == E1, S2.Element == E2, S3.Element == E3, S4.Element == E4, S5.Element == E5, S6.Element == E6 {
        
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()
        var it4 = s4.makeIterator()
        var it5 = s5.makeIterator()
        var it6 = s6.makeIterator()
        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next(), let e4 = it4.next(), let e5 = it5.next(), let e6 = it6.next() else { return nil }
            return (e1, e2, e3, e4, e5, e6)
        }
    }
    
    mutating func next() -> (E1, E2, E3, E4, E5, E6)? {
        return _next()
    }
}

struct Zip3Sequence<E1, E2, E3>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3)?
    
    init<S1: Sequence,
         S2: Sequence,
         S3: Sequence>(_ s1: S1,
                       _ s2: S2,
                       _ s3: S3) where S1.Element == E1, S2.Element == E2, S3.Element == E3 {
        
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()

        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next() else { return nil }
            return (e1, e2, e3)
        }
    }
    
    mutating func next() -> (E1, E2, E3)? {
        return _next()
    }
}


func zip6<S1: Sequence,
          S2: Sequence,
          S3: Sequence,
          S4: Sequence,
          S5: Sequence,
          S6: Sequence>(_ s1: S1,
                        _ s2: S2,
                        _ s3: S3,
                        _ s4: S4,
                        _ s5: S5,
                        _ s6: S6) -> Zip6Sequence<S1.Element, S2.Element, S3.Element, S4.Element, S5.Element, S6.Element> {
    return Zip6Sequence(s1, s2, s3, s4, s5, s6)
}

func zip3<S1: Sequence,
          S2: Sequence,
          S3: Sequence>(_ s1: S1,
                        _ s2: S2,
                        _ s3: S3) -> Zip3Sequence<S1.Element, S2.Element, S3.Element> {
    return Zip3Sequence(s1, s2, s3)
}
