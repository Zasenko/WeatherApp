//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.01.23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    let dateFormatter = DateFormatter() /// TODO! есть протокол
    
    // MARK: - Private properties

    private let presenter: WeatherPresenterProtocol
    private let rootView = CityRootView(frame: UIScreen.main.bounds)
    
    // MARK: - Inits

    init(presenter: WeatherPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life functions
    
    override func loadView() {
        super.loadView()
        self.view = rootView
        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
        
        rootView.dailyCollectionView.delegate = self
        rootView.dailyCollectionView.dataSource = self
        
        presenter.getWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .yellow
    }
}

// MARK: - @Objc func

extension WeatherViewController {
    @objc func addCityButtonTaped(sender: UIButton) {
//
    }
}

// MARK: - WeatherViewProtocol

extension WeatherViewController: WeatherViewProtocol {
    func setSaveButton() {
        let button1 = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addCityButtonTaped(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
    }

    func reloadLocation(name: String) {
        self.title = name
    }
    
    // TODO
    func changeWeather(place: CityModel) {
        if let weather = place.weather.currentWeather?.temperature {
            self.rootView.temperatureLable.text = String(weather)
        }
        self.rootView.weatherImage.image = place.weather.currentWeather?.weathercode.image
        
        self.rootView.hourlyCollectionView.reloadData()
        self.rootView.dailyCollectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate

extension WeatherViewController: UICollectionViewDelegate {}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rootView.hourlyCollectionView {
            return presenter.getHourlyWeatherCount()
        } else if collectionView == rootView.dailyCollectionView {
            return presenter.getDailyWeatherCount()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.hourlyCollectionView {
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
                return UICollectionViewCell()
            }
            if let hourWeather = presenter.getHourlyWeather(cell: indexPath.row) {
                var time = ""
                var temperature = ""
                switch hourWeather.type {
                case .weather:
                    dateFormatter.dateFormat = "HH"
                    time = dateFormatter.string(from: hourWeather.time)
                    temperature = String(hourWeather.temperature)
                case .sunrise:
                    dateFormatter.dateFormat = "HH:mm"
                    time = dateFormatter.string(from: hourWeather.time)
                    temperature = "sunrise"
                case .sunset:
                    dateFormatter.dateFormat = "HH:mm"
                    time = dateFormatter.string(from: hourWeather.time)
                    temperature = "sunset"
                }
                myCell.setupCell(time: time, temperature: temperature, image: hourWeather.weathercode.image)
            }
            return myCell
        } else {
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
                return UICollectionViewCell()
            }
            if let dayWeather = presenter.getDailyWeather(cell: indexPath.row) {
                
                dateFormatter.dateFormat = "MM-dd"
                
                let date = dateFormatter.string(from: dayWeather.date)
                
                let maxTemperatureString = String(dayWeather.temperatureMax)
                let minTemperatureString = String(dayWeather.temperatureMin)
                
                dateFormatter.dateFormat = "HH:mm"
                let sunsetString = dateFormatter.string(from: dayWeather.sunset)
                let sunriseString = dateFormatter.string(from: dayWeather.sunrise)
                
                let image = dayWeather.weathercode.image
                
                myCell.setupCell(date: date, image: image, maxMemperature: maxTemperatureString, minTemperature: minTemperatureString, sunrise: sunriseString, sunset: sunsetString)
            }
            return myCell
        }
    }
}
