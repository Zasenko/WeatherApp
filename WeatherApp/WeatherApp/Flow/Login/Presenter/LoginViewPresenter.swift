//
//  LoginViewPresenter.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 12.01.23.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func showLoginError(error: String)
}

protocol LoginViewPresenterProtocol: AnyObject {
    func loginButtonTapped(login: String?, password: String?)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: LoginViewProtocol?
    
    // MARK: - Private properties
    
    private let model = LoginModel()
    
    // MARK: - Inits
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    // MARK: - Func
    
    func loginButtonTapped(login: String?, password: String?) {
        switch model.isLoginPassWordCorrect(login: login, password: password) {
        case .success(_):
            view?.showLoginError(error: "введен правильный пароль")
        case .failure(let error):
            view?.showLoginError(error: error.rawValue)
        }
    }
}
