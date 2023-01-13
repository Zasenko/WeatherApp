//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.12.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: LoginViewPresenterProtocol!
    
    // MARK: - Private properties
    
    private var rootView = LoginViewControllerRootView(frame: UIScreen.main.bounds)
    
    // MARK: - Inits
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life func
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
}
extension LoginViewController {
    
    // MARK: - Private func
    
    private func addTargets() {
        rootView.logInButton.addTarget(self,
                                       action: #selector(buttonTaped(sender:)),
                                       for: .touchUpInside)
    }
    
    // MARK: - @Objc func
    
    @objc func buttonTaped(sender: UIButton) {
        presenter.loginButtonTapped(login: rootView.loginTextField.text, password: rootView.passwordTextField.text)
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginSuccess() {
        rootView.errorLable.text = nil
        navigationController?.pushViewController(MainScreenViewController(), animated: true)
    }
    
    func showLoginError(error: String) {
        rootView.errorLable.text = error
    }
}
