//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol CityViewProtocol: AnyObject {
    func reloadCity(img: UIImage, temp: String)
    func reloadTitle(title: String)
}

final class CityViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CityPresenterProtocol!
    
    // MARK: - Private properties
    
    private let rootView = CityRootView(frame: UIScreen.main.bounds)
    
    // MARK: - Inits
    
    init(){
        super.init(nibName: nil, bundle: nil)
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
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .yellow
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.18, green: 0.77, blue: 0.79, alpha: 1.00)

        rootView.hourlyCollectionView.delegate = self
        rootView.hourlyCollectionView.dataSource = self
        
        rootView.dailyTableView.delegate = self
        rootView.dailyTableView.dataSource = self
        
        presenter.getWeatherInfo()
    }
}

extension CityViewController: CityViewProtocol {
    func reloadTitle(title: String) {
        self.title = title
    }
    
    func reloadCity(img: UIImage, temp: String) {
        rootView.weatherImage.image = img
        rootView.temperatureLable.text = temp
        rootView.dailyTableView.reloadData()
        rootView.hourlyCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate

extension CityViewController: UICollectionViewDelegate {}

extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getHourlyWeatherCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as? HourlyWeatherCell else {
            return UICollectionViewCell()
        }
        if let hourWeather = presenter.getHourlyWeather(cell: indexPath.row) {
            myCell.setupCell(model: hourWeather)
        }
        return myCell
    }
}

//MARK: - UITableView Delegate

extension CityViewController: UITableViewDelegate {}

extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dailyWeatherCount = presenter.getDailyWeatherCount()
        self.rootView.tableViewHeight?.constant = Double(dailyWeatherCount) * self.rootView.cellHeight
        self.rootView.layoutIfNeeded()
        return dailyWeatherCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.identifier, for: indexPath) as? DailyWeatherCell else {
            return UITableViewCell()
        }
        if let dayWeather = presenter.getDailyWeather(cell: indexPath.row) {
            myCell.setupCell(madel: dayWeather)
        }
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rootView.cellHeight
    }
}
