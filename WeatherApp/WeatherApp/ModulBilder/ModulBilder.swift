//
//  ModulBilder.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 13.01.23.
//

import UIKit

protocol ModulBilderProtocol {
    func cteateTabBarModul(router: MainRouterProtocol) -> UITabBarController
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: CitiesViewPresenterDelegate) -> UIViewController
    func cteateCityModul(router: CitiesRouterProtocol, city: CityModel) -> UIViewController
    func cteateWeatherModul(router: WeatherRouterProtocol) -> UIViewController
}

class ModulBilder: ModulBilderProtocol {
    
    let networkManager = WeatherNetworkManager()
    
    func cteateTabBarModul(router: MainRouterProtocol) -> UITabBarController {
        let router = router
        let view = TabBarController()
        let presenter = TabBarPresenter(router: router)
        view.presenter = presenter
        return view
    }
    
    func cteateWeatherModul(router: WeatherRouterProtocol) -> UIViewController {
        let presenter = WeatherPresenter(networkManager: networkManager)
        let view = WeatherViewController(presenter: presenter)
        return view
    }
    
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController {
        let router = router
        let presenter = CitiesViewPresenter(router: router, networkManager: networkManager)
        let view = CitiesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: CitiesViewPresenterDelegate) -> UIViewController {
        
        let geoCodingManager = GeoCodingManager()
        let presenter = AddCityPresenter(router: router, geoCodingManager: geoCodingManager, delegate: delegate)
        let view = AddCityViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateCityModul(router: CitiesRouterProtocol, city: CityModel) -> UIViewController {
        let presenter = CityPresenter(router: router, networkManager: networkManager, city: city)
        let view = CityViewController(presenter: presenter)
        presenter.view = view
        return view
        
    }
}
