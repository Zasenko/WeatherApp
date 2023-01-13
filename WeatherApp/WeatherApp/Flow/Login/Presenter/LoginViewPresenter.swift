//
//  LoginViewPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 12.01.23.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func showLoginError(error: String)
    func loginSuccess()
}

protocol LoginViewPresenterProtocol: AnyObject {
    func loginButtonTapped(login: String?, password: String?)
}

class LoginViewPresenter {
    
    // MARK: - Properties
    
    var router: RouterProtocol?
    
    // MARK: - Private properties
    
    weak private var view: LoginViewProtocol?
    private let model = LoginModel()
    
    // MARK: - Inits
    
    required init(view: LoginViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension LoginViewPresenter: LoginViewPresenterProtocol {
    
    // MARK: - Func
    
    func loginButtonTapped(login: String?, password: String?) {
        switch model.isLoginPassWordCorrect(login: login, password: password) {
        case .success(_):
            view?.loginSuccess()
            router?.showTabBarController()
        case .failure(let error):
            view?.showLoginError(error: error.rawValue)
        }
    }
}
