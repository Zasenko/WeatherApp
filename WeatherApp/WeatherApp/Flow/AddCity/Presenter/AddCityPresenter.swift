//
//  AddCityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import Foundation

protocol AddCityViewProtocol: AnyObject {
    func reloadTableView()
}

protocol AddCityPresenterProtocol: AnyObject {
    func searchLocationByName(name: String)
    func addCityButtonTapped()
    func getCityCount() -> Int
    func getCity() -> CityModel?
}

//protocol AddCityPresenterDelegate: AnyObject {
//    func addedCity(city: CityModel)
//}

final class AddCityPresenter {
    
    // MARK: - Properties
    
    weak var view: AddCityViewProtocol?
 //   weak var delegate: AddCityPresenterDelegate?
    
    // MARK: - Private properties
    
    private let router: CitiesRouterProtocol
    private let geoCodingManager: GeoCodingManagerProtocol
    private var city: CityModel?
    private var coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, geoCodingManager: GeoCodingManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
        self.router = router
        self.geoCodingManager = geoCodingManager
     //   self.delegate = delegate
        self.coreDataManager = coreDataManager
    }
}

extension AddCityPresenter: AddCityPresenterProtocol {
    func getCity() -> CityModel? {
        return city
    }
    
    func getCityCount() -> Int {
        guard city != nil else {
            return 0
        }
        return 1
    }
    
    func searchLocationByName(name: String) {
        geoCodingManager.findCity(address: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let city):
                var city = city
                if self.coreDataManager.cities.first(where: {$0.name == city.name && $0.country == city.country}) != nil {
                    city.isSaved = true
                }
                DispatchQueue.main.async {
                    self.city = city
                    self.view?.reloadTableView()
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func addCityButtonTapped() {
        guard let city = self.city else { return }
        coreDataManager.save(city: city) { [weak self] result in
            guard let self = self else { return }
            if result {
                self.city?.isSaved = true
                self.view?.reloadTableView()
               // self.delegate?.addedCity(city: city)
            }
        }
    }
    
}
