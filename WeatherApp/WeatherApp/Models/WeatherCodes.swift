//
//  WeatherCodes.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import UIKit

enum WeatherCodes: Int {
    case clearSky
    case mainlyClearSky
    case partlyCloudy
    case cloudy
    case fog
    case drizzle
    case rain
    case freezingRain
    case thunderstormSlightOrModerate
    case snow
    case snowGrains
    case snowShowers
    case sunset, sunrise
    case unknown
}

extension WeatherCodes {
    var image: UIImage {
        switch self {
        case .clearSky:
            let image = UIImage(systemName: "sun.max.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
            return image ?? UIImage()
        case .mainlyClearSky:
            let image = UIImage(systemName: "sun.min.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
            return image ?? UIImage()
        case .partlyCloudy:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .yellow])
            let image = UIImage(systemName: "cloud.sun.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .cloudy:
            let image =  UIImage(systemName: "cloud.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal) ?? UIImage()
            return image
        case .fog:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            let image =  UIImage(systemName: "cloud.fog.fill", withConfiguration: conf) ?? UIImage()
            return image
        case .drizzle:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .blue])
            let image =  UIImage(systemName: "cloud.drizzle.fill", withConfiguration: conf) ?? UIImage()
            return image
        case .rain:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .blue])
            let image = UIImage(systemName: "cloud.rain.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .thunderstormSlightOrModerate:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .blue])
            let image = UIImage(systemName: "cloud.bolt.rain.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .snow:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            let image = UIImage(systemName: "cloud.snow.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .snowGrains:
            let image =  UIImage(systemName: "snowflake")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
            image.withTintColor(.blue)
            return image
        case .snowShowers:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            let image = UIImage(systemName: "cloud.snow.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .unknown :
            return UIImage()
        case .freezingRain:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            let image = UIImage(systemName: "cloud.sleet.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .sunset:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.white, .yellow])
            let image = UIImage(systemName: "sunset.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .sunrise:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.white, .yellow])
            let image = UIImage(systemName: "sunrise.fill", withConfiguration: conf)
            return image ?? UIImage()
        }
    }
}
