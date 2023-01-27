//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

final class CityViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let rootView = CityRootView(frame: UIScreen.main.bounds)
    
    // MARK: - Inits
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        rootView.appNameLable.text = name
        self.title = name
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
        self.view.backgroundColor = .orange
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .systemTeal
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
