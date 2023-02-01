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
            let image = UIImage(systemName: "sun.max.fill") ?? UIImage()
            image.withTintColor(.yellow)
            return image
        case .mainlyClearSky:
            let image = UIImage(systemName: "sun.min.fill") ?? UIImage()
            image.withTintColor(.yellow)
            return image
        case .partlyCloudy:
            let image =  UIImage(systemName: "cloud.sun.fill") ?? UIImage()
            image.withTintColor(.red)
            return image
        case .cloudy:
            let image =  UIImage(systemName: "cloud.fill") ?? UIImage()
            image.withTintColor(.gray)
            return image
        case .fog:
            let image =  UIImage(systemName: "cloud.fog.fill") ?? UIImage()
            image.withTintColor(.gray)
            return image
        case .drizzle:
            let image =  UIImage(systemName: "cloud.drizzle.fill") ?? UIImage()
            image.withTintColor(.gray)
            return image
        case .rain:
            let image =  UIImage(systemName: "cloud.rain.fill") ?? UIImage()
            image.withTintColor(.blue)
            return image
        case .snow:
            let image =  UIImage(systemName: "cloud.snow.fill") ?? UIImage()
            image.withTintColor(.blue)
            return image
        case .unknown :
            return UIImage()
        }
    }
}
