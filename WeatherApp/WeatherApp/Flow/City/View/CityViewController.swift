//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol CityViewProtocol: AnyObject {
    func reloadCity()
}

final class CityViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let rootView = CityRootView(frame: UIScreen.main.bounds)
    private let presenter: CityPresenterProtocol
    
    // MARK: - Inits
    
    init(presenter: CityPresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life func
    
    override func loadView() {
        self.view = rootView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getWeatherInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = presenter.city.name
        
        navigationController?.navigationBar.prefersLargeTitles = false
   //     navigationController?.navigationBar.barTintColor = .systemTeal
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
        
        rootView.dailyCollectionView.delegate = self
        rootView.dailyCollectionView.dataSource = self
    }
}

extension CityViewController: CityViewProtocol {
    func reloadCity() {
        if let weather = presenter.city.weather.currentWeather {
            rootView.weatherImage.image = weather.weathercode.image
        }
        if let temperatur = presenter.city.weather.currentWeather?.temperature {
            rootView.temperatureLable.text = "\(temperatur)"
        }
        rootView.dailyCollectionView.reloadData()
        rootView.hourlyCollectionView.reloadData()
    }
}

extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.rootView.hourlyCollectionView {
            print(presenter.getHourlyWeatherCount())
            return presenter.getHourlyWeatherCount()
        }
        return presenter.getDailyWeatherCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.hourlyCollectionView {
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
                return UICollectionViewCell()
            }
            if let hourlyWeather = presenter.city.weather.hourly?.weathers[indexPath.row] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                myCell.setupCell(time: dateFormatter.string(from: hourlyWeather.time), temperature: String(hourlyWeather.temperature), image: hourlyWeather.weathercode.image)
            }
            return myCell
        } else {
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
                return UICollectionViewCell()
            }
            if let dailyWeather = presenter.city.weather.daily?.weathers[indexPath.row] {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                
                let date = dateFormatter.string(from: dailyWeather.date)
                
                let maxTemperatureString = String(dailyWeather.temperatureMax)
                let minTemperatureString = String(dailyWeather.temperatureMin)
                
                dateFormatter.dateFormat = "dd:mm"
                let sunsetString = dateFormatter.string(from: dailyWeather.sunset)
                let sunriseString = dateFormatter.string(from: dailyWeather.sunrise)
                
                let image = dailyWeather.weathercode.image
                
                myCell.setupCell(date: date, image: image, maxMemperature: maxTemperatureString, minTemperature: minTemperatureString, sunrise: sunriseString, sunset: sunsetString)
            }
            return myCell
        }
    }
}
extension CityViewController: UICollectionViewDelegate {}
