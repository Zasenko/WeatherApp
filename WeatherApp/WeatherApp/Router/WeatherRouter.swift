//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.01.23.
//

import UIKit

protocol WeatherRouterProtocol: AbstractRouterProtocol {
    func showWeatherViewController()
}

final class WeatherRouter {
    
    var navigationController: UINavigationController?
    var modulBilder: ModulBilderProtocol?
    
    init(navigationController: UINavigationController, modulBilder: ModulBilderProtocol) {
        self.navigationController = navigationController
        self.modulBilder = modulBilder
    }
}

extension WeatherRouter: WeatherRouterProtocol {
    func showWeatherViewController() {
        if let navigationController = navigationController {
            guard let weatherVC = modulBilder?.cteateWeatherModul(router: self) else { return }
            navigationController.viewControllers = [weatherVC]
        }
    }
}
