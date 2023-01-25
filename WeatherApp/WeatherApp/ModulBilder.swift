//
//  ModulBilder.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 13.01.23.
//

import UIKit

protocol ModulBilderProtocol {
    func cteateLoginModul(router: RouterProtocol) -> UIViewController
    func cteateTabBarModul(router: RouterProtocol) -> UITabBarController
}

class ModulBilder: ModulBilderProtocol {
    func cteateLoginModul(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginViewPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func cteateTabBarModul(router: RouterProtocol) -> UITabBarController {
     //   let router = router
        let view = TabBarController()
     //   let presenter = TabBarViewPresenter(view: view)
     //   view.presenter = presenter
        return view
    }
}
