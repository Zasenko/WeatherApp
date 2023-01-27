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
    var data: [String]? {get set}
    func searchLocationByName(name: String)
}
 
final class AddCityPresenter {
    
    // MARK: - Properties
    
    let router: CitiesRouterProtocol?
    private let geoCodingManager: GeoCodingManager
    
    var data: [String]?
    
    // MARK: - Private properties
    
    weak private var view: AddCityViewProtocol?
    
    // MARK: - Inits
    
    required init(view: AddCityViewProtocol, router: CitiesRouterProtocol , geoCodingManager: GeoCodingManager) {
        self.view = view
        self.router = router
        self.geoCodingManager = geoCodingManager
    }
}

extension AddCityPresenter: AddCityPresenterProtocol {
    func searchLocationByName(name: String) {
        geoCodingManager.findCity(address: name) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            DispatchQueue.main.async {
                    self.data = result
                    self.view?.showFindedLocations()
            }
        }
    }
}
