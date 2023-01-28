//
//  ModulBilder.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 13.01.23.
//

import UIKit

protocol ModulBilderProtocol {
    func cteateLoginModul(router: MainRouterProtocol) -> UIViewController
    func cteateTabBarModul(router: MainRouterProtocol) -> UITabBarController
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController
    func cteateCityModul(router: CitiesRouterProtocol, name: String) -> UIViewController
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: AddCityViewControllerProtocol) -> UIViewController
}

class ModulBilder: ModulBilderProtocol {
    
    func cteateLoginModul(router: MainRouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginViewPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func cteateTabBarModul(router: MainRouterProtocol) -> UITabBarController {
        let router = router
        let view = TabBarController()
        let presenter = TabBarPresenter(router: router)
        view.presenter = presenter
        return view
    }
    
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController {
        let router = router
        let view = CitiesViewController()
        let networkManager = WeatherNetworkManager()
        let presenter = CitiesViewPresenter(view: view, router: router, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    func cteateCityModul(router: CitiesRouterProtocol, name: String) -> UIViewController {
      //  let router = router
        let view = CityViewController(name: name)
       // let presenter = CitiesViewPresenter(view: view, router: router)
       // view.presenter = presenter
        return view
    }
    
    
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: AddCityViewControllerProtocol) -> UIViewController {
        
        let geoCodingManager = GeoCodingManager()
        let presenter = AddCityPresenter(router: router, geoCodingManager: geoCodingManager, delegate: delegate)
        let view = AddCityViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}