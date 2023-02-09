//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.01.23.
//

import UIKit

final class WeatherViewController: UIViewController {
    
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
        rootView.dailyTableView.delegate = self
        rootView.dailyTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getWeather()
        self.title = "Weather"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .yellow
    }
}

// MARK: - @Objc func

extension WeatherViewController {
    @objc func saveButtonTapped(sender: UIButton) {
        presenter.saveButtonTouched()
    }
    
    @objc func deleteButtonTapped(sender: UIButton) {
        //
    }
}

// MARK: - WeatherViewProtocol

extension WeatherViewController: WeatherViewProtocol {
    func setSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem  = saveButton
    }
    
    func setSavedButton() {
        self.navigationItem.rightBarButtonItem = nil
        let savedButton = UIBarButtonItem(title: "saved", image: nil, target: self, action: nil)
        savedButton.isEnabled = false
        self.navigationItem.rightBarButtonItem  = savedButton
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func reloadLocationName(name: String) {
        self.title = name
    }
    
    // TODO
    func changeWeather(place: CityModel) {
        if let weather = place.weather.currentWeather?.temperature {
            self.rootView.temperatureLable.text = String(weather)
        }
        self.rootView.weatherImage.image = place.weather.currentWeather?.weathercode.image
        
        self.rootView.hourlyCollectionView.reloadData()
        self.rootView.dailyTableView.reloadData()
    }
}

// MARK: - UICollectionView Delegate

extension WeatherViewController: UICollectionViewDelegate {}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getHourlyWeatherCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        
    }
}

// MARK: - UITableView Delegate
extension WeatherViewController: UITableViewDelegate {}
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getDailyWeatherCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
            return UITableViewCell()
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

