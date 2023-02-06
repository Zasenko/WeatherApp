//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 13.01.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var presenter: TabBarPresenterProtocol
    
    init(presenter: TabBarPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        viewControllers = presenter.createTabBar()
    }
}

extension TabBarController: TabBarViewProtocol {
}

extension TabBarController {
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        tabBarItemAppearance.normal.iconColor = .gray
        
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
        tabBarItemAppearance.selected.iconColor = .yellow
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
