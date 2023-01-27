//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 13.01.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var presenter: TabBarPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.systemTeal
       
        tabBar.backgroundColor = UIColor.systemTeal
        
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarAppearance.backgroundColor = .systemTeal
        
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        tabBarItemAppearance.normal.iconColor = .gray
        
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabBarItemAppearance.selected.iconColor = .white
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers = presenter.createTabBar()
        self.navigationController?.isNavigationBarHidden = true
    }
}



class TabTwoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.title = "Настройки"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
