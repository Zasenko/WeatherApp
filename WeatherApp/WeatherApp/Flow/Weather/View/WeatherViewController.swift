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
        
        self.title = "Weather"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
        presenter.getLocation()
        
        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
        
        rootView.dailyCollectionView.delegate = self
        rootView.dailyCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
    }
}

extension WeatherViewController: WeatherViewProtocol {
    
    func changeLocation(place: CityModel) {
        print(place)
        self.title = place.name
        self.rootView.temperatureLable.text = place.country
    }
    
    func changeWeather(place: CityModel) {
        if let weather = place.weather.currentWeather?.temperature {
            self.rootView.temperatureLable.text = String(weather)
        }
        
        self.rootView.weatherImage.image = place.weather.currentWeather?.weathercode.image
        self.rootView.hourlyCollectionView.reloadData()
        self.rootView.dailyCollectionView.reloadData()
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
