//
//  CitiesViewPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import Foundation

protocol CitiesViewProtocol: AnyObject {
}

protocol CitiesViewPresenterProtocol: AnyObject {
    func cellTaped(name: String)
    func addButtonTapped()
}

class CitiesViewPresenter {
    
    // MARK: - Properties
    
    var router: CitiesRouterProtocol?
    
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
}
