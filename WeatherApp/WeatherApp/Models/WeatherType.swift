//
//  WeatherCodes.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import UIKit

enum WeatherType: Int {
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

extension WeatherType {
    var image: UIImage {
        switch self {
        case .clearSky:
            return AppImages.clearSky?.withTintColor(.yellow, renderingMode: .alwaysOriginal) ?? AppImages.emptyImage
        case .mainlyClearSky:
            return AppImages.mainlyClearSky?.withTintColor(.yellow, renderingMode: .alwaysOriginal) ?? AppImages.emptyImage
        case .partlyCloudy:
            return AppImages.mainlyClearSky?.withTintColor(.yellow, renderingMode: .alwaysOriginal) ?? AppImages.emptyImage
        case .cloudy:
            return AppImages.cloudy?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal) ?? AppImages.emptyImage
        case .fog:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            return AppImages.fog?.withConfiguration(conf) ?? AppImages.emptyImage
        case .drizzle:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .blue])
            return AppImages.drizzle?.withConfiguration(conf) ?? AppImages.emptyImage
        case .rain:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .blue])
            return AppImages.rain?.withConfiguration(conf) ?? AppImages.emptyImage
        case .thunderstormSlightOrModerate:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .blue])
            return AppImages.thunderstormSlightOrModerate?.withConfiguration(conf) ?? AppImages.emptyImage
        case .snow:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            return AppImages.snow?.withConfiguration(conf) ?? AppImages.emptyImage
        case .snowGrains:
            return AppImages.snowGrains?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? AppImages.emptyImage
        case .snowShowers:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            return AppImages.snow?.withConfiguration(conf) ?? AppImages.emptyImage
        case .unknown :
            return AppImages.emptyImage
        case .freezingRain:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.systemGray4, .white])
            return AppImages.freezingRain?.withConfiguration(conf) ?? AppImages.emptyImage
        case .sunset:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.white, .yellow])
            return AppImages.sunset?.withConfiguration(conf) ?? AppImages.emptyImage
        case .sunrise:
            let conf = UIImage.SymbolConfiguration(paletteColors: [.white, .yellow])
            return AppImages.sunrise?.withConfiguration(conf) ?? AppImages.emptyImage
        }
    }
}
