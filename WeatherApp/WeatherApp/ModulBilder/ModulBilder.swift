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
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: AddCityPresenterDelegate) -> UIViewController
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
        let presenter = WeatherPresenter(networkManager: networkManager, geoCoder: geoCodingManager, locationManager: locationManager, dateFormatter: dateFormatterManager)
        let view = WeatherViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateCitiesModul(router: CitiesRouterProtocol) -> UIViewController {
        let presenter = CitiesViewPresenter(router: router, networkManager: networkManager, dateFormatter: dateFormatterManager, coreDataManager: coreDataManager)
        let view = CitiesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateAddCityModul(router: CitiesRouterProtocol, delegate: AddCityPresenterDelegate) -> UIViewController {
        let presenter = AddCityPresenter(router: router, geoCodingManager: geoCodingManager, delegate: delegate, coreDataManager: coreDataManager)
        let view = AddCityViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func cteateCityModul(router: CitiesRouterProtocol, city: CityModel) -> UIViewController {
        let presenter = CityPresenter(router: router, networkManager: networkManager, city: city, dateFormatter: dateFormatterManager)
        let view = CityViewController(presenter: presenter)
        presenter.view = view
        return view
        
    }
}
