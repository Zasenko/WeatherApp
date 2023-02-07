//
//  AddCityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import Foundation

protocol AddCityViewProtocol: AnyObject {
    func showFindedLocations()
    func reloadAddButton()
}

protocol AddCityPresenterProtocol: AnyObject {
    func searchLocationByName(name: String)
    func addCityButtonTapped(city: CityModel)
    func getCityCount() -> Int
    func getCity() -> CityModel?
}

final class AddCityPresenter {
    
    // MARK: - Properties
    
    weak var view: AddCityViewProtocol?
    weak var delegate: CitiesViewPresenterDelegate?
    
    // MARK: - Private properties
    
    private let router: CitiesRouterProtocol
    private let geoCodingManager: GeoCodingManagerProtocol
    private var city: CityModel?
    private var coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, geoCodingManager: GeoCodingManagerProtocol, delegate: CitiesViewPresenterDelegate, coreDataManager: CoreDataManagerProtocol) {
        self.router = router
        self.geoCodingManager = geoCodingManager
        self.delegate = delegate
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
                DispatchQueue.main.async {
                    self.city = city
                    self.view?.showFindedLocations()
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
//    let singer = DataManager.shared.singer(name: textfield.text ?? "")
//    singers.append(singer)
//    DataManager.shared.save()
//    self.tableView.reloadData()
    
    func addCityButtonTapped(city: CityModel) {
        let city = coreDataManager.makeCity(city: city)
        coreDataManager.cities.append(city)
        coreDataManager.save()
        view?.reloadAddButton()
        delegate?.addCity()//(city: city)
    }
}
