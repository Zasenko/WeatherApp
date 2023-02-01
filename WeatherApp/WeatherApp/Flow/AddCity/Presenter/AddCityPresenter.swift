//
//  AddCityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import Foundation

protocol AddCityViewProtocol: AnyObject {
    func showFindedLocations()
}

protocol AddCityPresenterProtocol: AnyObject {
    var city: CityModel? { get set }
    func searchLocationByName(name: String)
    func addCityButtonTapped(city: CityModel)
}

final class AddCityPresenter {
    
    // MARK: - Properties
    
    weak var view: AddCityViewProtocol?
    weak var delegate: CitiesViewPresenterDelegate?
    var city: CityModel?
    
    // MARK: - Private properties
    
    private let router: CitiesRouterProtocol?
    private let geoCodingManager: GeoCodingManagerProtocol
        
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, geoCodingManager: GeoCodingManagerProtocol, delegate: CitiesViewPresenterDelegate) {
        self.router = router
        self.geoCodingManager = geoCodingManager
        self.delegate = delegate
    }
}

extension AddCityPresenter: AddCityPresenterProtocol {
    
    func searchLocationByName(name: String) {
        geoCodingManager.findCity(address: name) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            DispatchQueue.main.async {
                    self.city = result
                    self.view?.showFindedLocations()
            }
        }
    }
    
    func addCityButtonTapped(city: CityModel) {
        delegate?.addCity(city: city)
    }
}
