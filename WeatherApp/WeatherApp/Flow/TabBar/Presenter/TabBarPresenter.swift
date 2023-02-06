//
//  TabBarPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
}

protocol TabBarPresenterProtocol: AnyObject {
    func createTabBar() -> [UIViewController]
}

final class TabBarPresenter {
    
    // MARK: - Properties
    
    weak var view: TabBarViewProtocol?
    let router: MainRouterProtocol
    
    // MARK: - Inits
    
    required init(router: MainRouterProtocol) {
        self.router = router
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
    
    func createTabBar() -> [UIViewController] {

        let weatherNavController = UINavigationController()
        if let builder = router.modulBilder {
            let router = WeatherRouter(navigationController: weatherNavController, modulBilder: builder)
            router.showWeatherViewController()
        }
        let tabOneBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "location"), selectedImage: UIImage(systemName: "location.fill"))
        weatherNavController.tabBarItem = tabOneBarItem

        let citiesNavController = UINavigationController()
        if let builder = router.modulBilder {
            let router = CitiesRouter(navigationController: citiesNavController, modulBilder: builder)
            router.initialCitiesViewController()
        }
        
        let tabBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        citiesNavController.tabBarItem = tabBarItem
        
        return [weatherNavController, citiesNavController]
    }
}
