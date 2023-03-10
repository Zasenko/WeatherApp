//
//  AbstractRouterProtocol.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 13.01.23.
//

import UIKit

protocol MainRouterProtocol: AbstractRouterProtocol {
    func showTabBarController()
    func popToRoot()
}

final class MainRouter: MainRouterProtocol {
    
    var navigationController: UINavigationController?
    var modulBilder: ModulBilderProtocol?
    
    init(navigationController: UINavigationController, modulBilder: ModulBilderProtocol) {
        self.navigationController = navigationController
        self.modulBilder = modulBilder
    }
}

extension MainRouter {
    func showTabBarController() {
        if let navigationController = navigationController {
            guard let tabBarController = modulBilder?.cteateTabBarModul(router: self) else { return }
            navigationController.pushViewController(tabBarController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
