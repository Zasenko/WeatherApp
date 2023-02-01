//
//  WeatherCodes.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import UIKit

enum WeatherCodes {
    case clearSky
    case mainlyClearSky
    case partlyCloudy
    case cloudy
    case fog
    case drizzle
    case rain
    case snow
    case unknown
}

extension WeatherCodes {
    var image: UIImage {
        switch self {
        case .clearSky:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray5, .yellow])
            let image = UIImage(systemName: "sun.max.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .mainlyClearSky:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray5, .yellow])
            let image = UIImage(systemName: "sun.max.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .partlyCloudy:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray5, .yellow])
            let image = UIImage(systemName: "cloud.sun.fill", withConfiguration: conf)
            return image ?? UIImage()
        case .cloudy:
            let image =  UIImage(systemName: "cloud.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal) ?? UIImage()
            image.withTintColor(.gray)
            return image ?? UIImage()
        case .fog:
            let image =  UIImage(systemName: "cloud.fog.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) ?? UIImage()
            image.withTintColor(.gray)
            return image
        case .drizzle:
            let image =  UIImage(systemName: "cloud.drizzle.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal) ?? UIImage()
            image.withTintColor(.gray)
            return image
        case .rain:
            let image =  UIImage(systemName: "cloud.rain.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal) ?? UIImage()
            image.withTintColor(.blue)
            return image
        case .snow:
            let image =  UIImage(systemName: "cloud.snow.fill")?.withTintColor(.blue, renderingMode: .alwaysOriginal) ?? UIImage()
            image.withTintColor(.blue)
            return image
        case .unknown :
            return UIImage()
        }
    }
}
