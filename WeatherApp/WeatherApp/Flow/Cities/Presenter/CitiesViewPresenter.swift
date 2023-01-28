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
    var cities: [GeoCodingCityModel] { get set }
    func cellTaped(name: String)
    func addButtonTapped()
    func addNewCity(city: GeoCodingCityModel)
}

final class CitiesViewPresenter {
    
    // MARK: - Properties
    
    let router: CitiesRouterProtocol?
    var cities: [GeoCodingCityModel] = []
    
    // MARK: - Private properties
    
    weak private var view: CitiesViewProtocol?
    
    // MARK: - Inits
    
    required init(view: CitiesViewProtocol, router: CitiesRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension CitiesViewPresenter: CitiesViewPresenterProtocol {

    func cellTaped(name: String) {
        router?.showCityViewController(name: name)
    }
    
    func addButtonTapped() {
        router?.showAddCityViewController()
    }
    
    func addNewCity(city: GeoCodingCityModel) {
        cities.append(city)
        view?.reloadTableView()
    }
}
