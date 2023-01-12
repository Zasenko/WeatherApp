//
//  LoginViewControllerRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.12.22.
//

import UIKit

class LoginViewControllerRootView: UIView {
    
    //MARK: - SubViews
    
    let appNameLable: UILabel = {
        let lable = UILabel()
        lable.text = "WEATHER APP"
        lable.font = .boldSystemFont(ofSize: 40)
        lable.textAlignment = .center
        return lable
    }()
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.placeholder = "login"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.red.cgColor
        textField.placeholder = "password"
        return textField
    }()
    
    
    let logInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemMint
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        logInButton.layer.cornerRadius = 10
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewControllerRootView {
    
    //MARK: - Private Functions
    
    private func addSubViews() {
        addSubview(appNameLable)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(logInButton)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        createAppNameLableConstraint()
        createLoginTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createlogInButtonConstraint()
    }
    
    private func createAppNameLableConstraint() {
        appNameLable.translatesAutoresizingMaskIntoConstraints = false
        appNameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        appNameLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        appNameLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func createLoginTextFieldConstraint() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.topAnchor.constraint(equalTo: appNameLable.bottomAnchor, constant: 50).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    }
    
    private func createPasswordTextFieldConstraint() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    }
    
    private func createlogInButtonConstraint() {
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        logInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logInButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.5).isActive = true
    }
}
