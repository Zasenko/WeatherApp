//
//  CitiesViewPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import Foundation

protocol CitiesViewProtocol: AnyObject {
    func reloadTableView()
}

protocol CitiesViewPresenterProtocol: AnyObject {
    var cities: [CityModel] { get set }
    func cellTaped(indexPath: IndexPath)
    func addButtonTapped()
    func addNewCity(city: CityModel)
}

protocol CitiesViewPresenterDelegate: AnyObject {
    func addCity(city: CityModel)
}

final class CitiesViewPresenter {
    
    // MARK: - Properties

    weak var view: CitiesViewProtocol?
    var cities: [CityModel] = []
    
    // MARK: - Private properties
    
    private let networkManager: WeatherNetworkManagerProtocol
    private let router: CitiesRouterProtocol
    private let dateFormatter: DateFormatterManagerProtocol
    
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, networkManager: WeatherNetworkManagerProtocol, dateFormatter: DateFormatterManagerProtocol) {
        self.router = router
        self.networkManager = networkManager
        self.dateFormatter = dateFormatter
    }
}

extension CitiesViewPresenter {
    
    private func addedCity(city: CityModel) {
                var city = city
                networkManager.fetchCurrentWeatherByLocation(latitude: String(city.coordinate.latitude), longitude: String(city.coordinate.longitude), complition: { [weak self] result in
                    guard let self = self else {return}
        
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let location):
                            if let currentWeathe = location.currentWeather {
                                if city.changeData(currentWeather: currentWeathe, hourlyWeather: nil, dailyWeather: nil, dateFormatter: self.dateFormatter) {
                                    self.cities.append(city)
                                }
                            }
                            self.view?.reloadTableView()
                        case .failure(let error):
                            print(error)
                        }
                    }
                })
    }
}

extension CitiesViewPresenter: CitiesViewPresenterProtocol {

    func cellTaped(indexPath: IndexPath) {
        router.showCityViewController(city: cities[indexPath.row])
    }
    
    func addButtonTapped() {
        router.showAddCityViewController(delegate: self)
    }
    
    func addNewCity(city: CityModel) {
        cities.append(city)
        view?.reloadTableView()
    }
}

extension CitiesViewPresenter: CitiesViewPresenterDelegate {
    func addCity(city: CityModel) {
        addedCity(city: city)
    }
}
