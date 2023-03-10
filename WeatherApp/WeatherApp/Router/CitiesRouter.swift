//
//  CitiesRouter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol CitiesRouterProtocol: AbstractRouterProtocol {
    func initialCitiesViewController()
    func showCityViewController(city: CityModel)
    func showAddCityViewController()
}

final class CitiesRouter: CitiesRouterProtocol {
    var navigationController: UINavigationController?
    var modulBilder: ModulBilderProtocol?
    
    init(navigationController: UINavigationController, modulBilder: ModulBilderProtocol) {
        self.navigationController = navigationController
        self.modulBilder = modulBilder
    }
}

extension CitiesRouter {
    func initialCitiesViewController() {
        if let navigationController = navigationController {
            guard let citiesVC = modulBilder?.cteateCitiesModul(router: self) else { return }
            navigationController.viewControllers = [citiesVC]
        }
    }
    
    func showCityViewController(city: CityModel) {
        if let navigationController = navigationController {
            guard let cityViewController = modulBilder?.cteateCityModul(router: self, city: city) else { return }
            navigationController.pushViewController(cityViewController, animated: true)
        }
    }
    
    func showAddCityViewController() {
        if let navigationController = navigationController {
            guard let addCityCV = modulBilder?.cteateAddCityModul(router: self) else {return}
            
            let navController = UINavigationController(rootViewController: addCityCV)
            navController.modalPresentationStyle = .formSheet
            navigationController.present(navController, animated: true)
        }
    }
}
