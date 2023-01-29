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
    func cteateCityModul(router: CitiesRouterProtocol, name: String) -> UIViewController
    func cteateWeatherModul(router: WeatherRouterProtocol) -> UIViewController
}

class ModulBilder: ModulBilderProtocol {
    
    func cteateTabBarModul(router: MainRouterProtocol) -> UITabBarController {
        let router = router
        let view = TabBarController()
        let presenter = TabBarPresenter(router: router)
        view.presenter = presenter
        return view
    }
    
    func cteateWeatherModul(router: WeatherRouterProtocol) -> UIViewController {
        let view = WeatherViewController()
        return view
    }
    
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController {
        let router = router
        let networkManager = WeatherNetworkManager()
        let presenter = CitiesViewPresenter(router: router, networkManager: networkManager)
        let view = CitiesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: CitiesViewPresenterDelegate) -> UIViewController {
        
        let geoCodingManager = GeoCodingManager()
        let presenter = AddCityPresenter(router: router, geoCodingManager: geoCodingManager)
        let view = AddCityViewController(presenter: presenter)
        presenter.view = view
        presenter.delegate = delegate
        return view
    }
    
    func cteateCityModul(router: CitiesRouterProtocol, name: String) -> UIViewController {
      //  let router = router
        let view = CityViewController(name: name)
       // let presenter = CitiesViewPresenter(view: view, router: router)
       // view.presenter = presenter
        return view
    }
}
