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
    var city: GeoCodingCityModel? { get set }
    func searchLocationByName(name: String)
    func addCityButtonTapped(city: GeoCodingCityModel)
}
 
final class AddCityPresenter {
    
    // MARK: - Properties
    weak var view: AddCityViewProtocol?
    var city: GeoCodingCityModel?
    
    // MARK: - Private properties
    
    private let router: CitiesRouterProtocol?
    private let geoCodingManager: GeoCodingManager
    
    weak private var delegate: AddCityViewControllerProtocol?
    
    // MARK: - Inits
    
    required init(router: CitiesRouterProtocol, geoCodingManager: GeoCodingManager, delegate: AddCityViewControllerProtocol) {
        self.router = router
        self.delegate = delegate
        self.geoCodingManager = geoCodingManager
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
    
    func addCityButtonTapped(city: GeoCodingCityModel) {
        delegate?.addedCity(city: city)
    }
}
