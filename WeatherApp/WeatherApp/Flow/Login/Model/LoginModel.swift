//
//  LoginModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 12.01.23.
//

import Foundation

enum LoginModelErrors: String, Error {
    case emptyLogin = "Enter your login please"
    case emptyPassword = "Enter your password please"
}

struct LoginModel {
    
    // MARK: - Func
    
    func isLoginPassWordCorrect(login: String?, password: String?) -> Result<Bool,LoginModelErrors> {
        
        guard let login = login, !login.isEmpty else {
            return .failure(LoginModelErrors.emptyLogin)
        }
        guard let password = password, !password.isEmpty else {
            return .failure(LoginModelErrors.emptyPassword)
        }
        return .success(true)
    }
}
