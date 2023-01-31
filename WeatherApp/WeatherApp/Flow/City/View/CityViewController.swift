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
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .systemTeal
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
        
        rootView.dailyCollectionView.delegate = self
        rootView.dailyCollectionView.dataSource = self
    }
}

extension CityViewController: CityViewProtocol {
    func reloadCity() {
        if let image = presenter.city.currentWeather?.weathercode.image {
            rootView.weatherImage.image = image
        }
        if let temperatur = presenter.city.currentWeather?.temperature {
            rootView.temperatureLable.text = "\(temperatur)"
        }
        rootView.dailyCollectionView.reloadData()
        rootView.hourlyCollectionView.reloadData()
    }
}

//extension CityViewController: UICollectionViewDataSource {}

extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.rootView.hourlyCollectionView {
//            print(presenter.getHourlyWeatherCount())
//            return presenter.getHourlyWeatherCount()
//        }
        return presenter.getDailyWeatherCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.hourlyCollectionView {
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
                return UICollectionViewCell()
            }
                    var temperatureString: String?
                    if let temperature = presenter.city.hourly?.temperature[indexPath.row] {
                        temperatureString = String(temperature)
                    }

                    var timeString = ""
                    if let time = presenter.city.hourly?.time[indexPath.row] {

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        timeString = dateFormatter.string(from: time)
                    }

                    var weathercodeImage: UIImage?
                    if let weathercode = presenter.city.hourly?.weathercode[indexPath.row].image {
                        weathercodeImage = weathercode
                    }

            myCell.setupCell(time: timeString, temperature: temperatureString ?? "", image: weathercodeImage ?? UIImage())
            return myCell
        } else {
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
                return UICollectionViewCell()
            }
            
            var maxTemperatureString: String = ""
            if let maxTemperature = presenter.city.daily?.temperatureMax[indexPath.row] {
                maxTemperatureString = String(maxTemperature)
            }
            
            var minTemperatureString: String = ""
            if let mixTemperature = presenter.city.daily?.temperatureMin[indexPath.row] {
                minTemperatureString = String(mixTemperature)
            }

            var sunsetString: String = ""
            if let sunset = presenter.city.daily?.sunset[indexPath.row] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd:mm"
                sunsetString = dateFormatter.string(from: sunset)
            }
            
            var sunriseString: String = ""
            if let sunrise = presenter.city.daily?.sunrise[indexPath.row] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd:mm"
                sunriseString = dateFormatter.string(from: sunrise)
            }
            
            var weathercodeImage = UIImage()
            if let weathercode = presenter.city.hourly?.weathercode[indexPath.row].image {
                weathercodeImage = weathercode
            }
            
            var dateString = ""
            if let time = presenter.city.daily?.time[indexPath.row] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd:mm"
                dateString = dateFormatter.string(from: time)
            }
            print(dateString, weathercodeImage, sunriseString, sunsetString, minTemperatureString, maxTemperatureString)
            myCell.setupCell(date: dateString, image: weathercodeImage, maxMemperature: maxTemperatureString, minTemperature: minTemperatureString, sunrise: sunriseString, sunset: sunsetString)
            return myCell
        }
    }
}
extension CityViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}
