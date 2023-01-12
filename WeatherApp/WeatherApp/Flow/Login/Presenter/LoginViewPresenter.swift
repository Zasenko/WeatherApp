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
    
    private let model = LoginModel()
    weak var view: LoginViewProtocol?
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func loginButtonTapped(login: String?, password: String?) {
        
        switch model.isLoginPassWordCorrect(login: login, password: password) {
            
        case .success(_):
            view?.showLoginError(error: "введен правильный пароль")
        case .failure(let error):
            view?.showLoginError(error: "введен неправильный пароль \(error)")
        }
    }
}
