//
//  AddCityPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import Foundation

protocol AddCityViewProtocol: AnyObject {}

protocol AddCityPresenterProtocol: AnyObject {}
 
final class AddCityPresenter {
    
    // MARK: - Properties
    
    var router: CitiesRouterProtocol?
     
    // MARK: - Private properties
    
    weak private var view: AddCityViewProtocol?
    
    // MARK: - Inits
    
    required init(view: AddCityViewProtocol, router: CitiesRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension AddCityPresenter: AddCityPresenterProtocol {}
