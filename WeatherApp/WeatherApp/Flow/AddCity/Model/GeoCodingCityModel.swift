//
//  CityModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 27.01.23.
//

import Foundation
import CoreLocation
import UIKit

enum WeatherCodes {
    case clearSky
    case partlyCloudy
    case cloudy
    case rain
    case snow
    case unknown
}

extension WeatherCodes {
    var image: UIImage {
        switch self {
        case .clearSky:
            return UIImage(systemName: "sun.max.fill")?.withTintColor(.yellow) ?? UIImage()
        case .partlyCloudy:
            return UIImage(systemName: "cloud.sun.fill") ?? UIImage()
        case .cloudy:
            return UIImage(systemName: "cloud.fill")?.withTintColor(.gray) ?? UIImage()
        case .rain:
            return UIImage(systemName: "cloud.rain.fill")?.withTintColor(.blue) ?? UIImage()
        case .snow:
            return UIImage(systemName: "cloud.snow.fill")?.withTintColor(.blue) ?? UIImage()
        case .unknown :
            return UIImage()
        }
    }
}

struct GeoCodingCityModel {
    let coordinate: CLLocationCoordinate2D
    let name: String
    let country: String
    
    var currentWeather: CityWeather?
}

struct CityWeather {
    let temperature: Double
    let weathercode: WeatherCodes
}

///WMO Weather interpretation codes (WW)
///Code    Description
///0    Clear sky
///1, 2, 3    Mainly clear, partly cloudy, and overcast
///45, 48    Fog and depositing rime fog
///51, 53, 55    Drizzle: Light, moderate, and dense intensity
///56, 57    Freezing Drizzle: Light and dense intensity
///61, 63, 65    Rain: Slight, moderate and heavy intensity
///66, 67    Freezing Rain: Light and heavy intensity
///71, 73, 75    Snow fall: Slight, moderate, and heavy intensity
///77    Snow grains
///80, 81, 82    Rain showers: Slight, moderate, and violent
///85, 86    Snow showers slight and heavy
///95 *    Thunderstorm: Slight or moderate
///96, 99 *    Thunderstorm with slight and heavy hail
///(*) Thunderstorm forecast with hail is only available in Central Europe
