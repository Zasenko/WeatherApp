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
    func cteateAddCityModul(router: CitiesRouterProtocol) -> UIViewController
    func cteateCityModul(router: CitiesRouterProtocol, city: CityModel) -> UIViewController
    func cteateWeatherModul(router: WeatherRouterProtocol) -> UIViewController
}

final class ModulBilder: ModulBilderProtocol {
    
    private let networkManager = WeatherNetworkManager()
    private let geoCodingManager = GeoCodingManager()
    private let dateFormatterManager = DateFormatterManager()
    private let coreDataManager = CoreDataManager()
    
    func cteateTabBarModul(router: MainRouterProtocol) -> UITabBarController {
        let presenter = TabBarPresenter(router: router)
        let view = TabBarController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateWeatherModul(router: WeatherRouterProtocol) -> UIViewController {
        let locationManager = LocationManager()
        let view = WeatherViewController()
        let presenter = WeatherPresenter(view: view, networkManager: networkManager, geoCoder: geoCodingManager, locationManager: locationManager, dateFormatter: dateFormatterManager, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController {
        let view = CitiesViewController()
        let presenter = CitiesViewPresenter(view: view, router: router, networkManager: networkManager, dateFormatter: dateFormatterManager, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func cteateAddCityModul(router: CitiesRouterProtocol) -> UIViewController {
        let view = AddCityViewController()
        let presenter = AddCityPresenter(view: view, router: router, geoCodingManager: geoCodingManager, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func cteateCityModul(router: CitiesRouterProtocol, city: CityModel) -> UIViewController {
        let view = CityViewController()
        let presenter = CityPresenter(view: view, router: router, networkManager: networkManager, city: city, dateFormatter: dateFormatterManager)
        view.presenter = presenter
        return view
        
    }
}
