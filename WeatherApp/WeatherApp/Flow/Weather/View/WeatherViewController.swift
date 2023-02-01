//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.01.23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let presenter: WeatherPresenterProtocol
    private let rootView = CityRootView(frame: UIScreen.main.bounds)
    
    init(presenter: WeatherPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.getLocation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.title = "Weather"
        
        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
        
        rootView.dailyCollectionView.delegate = self
        rootView.dailyCollectionView.dataSource = self
    }
}

extension WeatherViewController: WeatherViewProtocol {
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
