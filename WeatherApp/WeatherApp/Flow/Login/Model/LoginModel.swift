//
//  LoginModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 12.01.23.
//

import Foundation

enum LoginModelErrors: Error {
    case emptyLogin, emptyPassword
}

struct LoginModel {
    
    func isLoginPassWordCorrect(login: String?, password: String?) -> Result<Bool,LoginModelErrors> {
        
        guard let login = login else {
            return .failure(LoginModelErrors.emptyLogin)
        }
        
        guard let password = password else {
            return .failure(LoginModelErrors.emptyPassword)
        }
        
        guard !login.isEmpty else {
            return .failure(LoginModelErrors.emptyLogin)
        }
        
        guard !password.isEmpty else {
            return .failure(LoginModelErrors.emptyPassword)
        }
        return .success(true)
    }
}
