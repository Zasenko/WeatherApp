//
//  TabBarPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol TabBarPresenterProtocol {
    func createTabBar() -> [UIViewController]
}

class TabBarPresenter {
    
    // MARK: - Properties
    
    var router: MainRouterProtocol?
    
    // MARK: - Inits
    
    required init(router: MainRouterProtocol) {
        self.router = router
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
    func createTabBar() -> [UIViewController] {

        let navigationController = UINavigationController()
        if let builder = router?.modulBilder {
            let router = CitiesRouter(navigationController: navigationController, modulBilder: builder)
            router.initialCitiesViewController()
        }
  
        let tabOneBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        navigationController.tabBarItem = tabOneBarItem
        navigationController.navigationBar.largeContentTitle = "Cities"
        
        
        let view = TabTwoViewController()
        let tabBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        view.tabBarItem = tabBarItem
        return [navigationController, view]
    }
}
