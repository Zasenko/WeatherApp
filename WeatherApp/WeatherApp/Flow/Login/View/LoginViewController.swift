//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.12.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var rootView: LoginViewControllerRootView { return self.view as! LoginViewControllerRootView }
    
    // MARK: - Inits
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life func
    
    override func loadView() {
        self.view = LoginViewControllerRootView(frame: UIScreen.main.bounds)
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
    }
}
