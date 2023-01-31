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
        self.view.backgroundColor = .orange
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .systemTeal
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
    }
}

extension CityViewController: CityViewProtocol {
    func reloadCity() {
        if let image = presenter.city.currentWeather?.weathercode?.image {
            rootView.weatherImage.image = image
        }
        if let temperatur = presenter.city.currentWeather?.temperature {
            rootView.temperatureLable.text = "\(temperatur)"
        }
        rootView.hourlyCollectionView.reloadData()
    }
}

//extension CityViewController: UICollectionViewDataSource {}

extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(presenter.city.hourly?.temperature?.count ?? "-0-0-0-0-0-0")
        return presenter.city.hourly?.temperature?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
            return UICollectionViewCell()
        }
        
        myCell.backgroundColor = UIColor.blue
        
                var temperatureString: String?
                if let temperature = presenter.city.hourly?.temperature?[indexPath.row] {
                    temperatureString = String(temperature)
                }
        
                var timeString: String?
                if let time = presenter.city.hourly?.time?[indexPath.row] {
                    timeString = String(time)
                }
        
                var weathercodeImage: UIImage?
                if let weathercode = presenter.city.hourly?.weathercode?[indexPath.row].image {
                    weathercodeImage = weathercode
                }
        myCell.setupCell(time: timeString ?? "sads", temperature: temperatureString ?? "sdf", image: weathercodeImage ?? UIImage())
        return myCell
    }
}
extension CityViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}
//extension CityViewController: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        print(presenter.getHourlyWeatherCount())
////        return presenter.getHourlyWeatherCount()
//        3
//        }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
//            return UICollectionViewCell()
//        }
//        print(presenter.city)
//        // TODO - получение готовых данных
//        var temperatureString: String?
//        if let temperature = presenter.city.hourly?.temperature?[indexPath.row] {
//            temperatureString = String(temperature)
//        }
//
//        var timeString: String?
//        if let time = presenter.city.hourly?.time?[indexPath.row] {
//            timeString = String(time)
//        }
//
//        var weathercodeImage: UIImage?
//        if let weathercode = presenter.city.hourly?.weathercode?[indexPath.row].image {
//            weathercodeImage = weathercode
//        }
//        cell.setupCell(time: timeString ?? "", temperature: temperatureString ?? "", image: weathercodeImage ?? UIImage())
//        return cell
//    }
//}
