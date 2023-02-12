//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 29.01.23.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func reloadLocationName(name: String)
    func changeWeather(img: UIImage, temp: String)
    func setSaveButton()
    func setSavedButton()
}

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WeatherPresenterProtocol!
    let dateFormatter = DateFormatter() /// TODO! есть протокол
    
    // MARK: - Private properties

    private let rootView = CityRootView(frame: UIScreen.main.bounds)
    
    // MARK: - Inits
    
    init() {
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
        navigationController?.navigationBar.tintColor = .yellow
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.18, green: 0.77, blue: 0.79, alpha: 1.00)
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
    
    func changeWeather(img: UIImage, temp: String) {
        rootView.temperatureLable.text = temp
        rootView.weatherImage.image = img
        rootView.hourlyCollectionView.reloadData()
        rootView.dailyTableView.reloadData()
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
            myCell.setupCell(model: hourWeather)
        }
        return myCell
    }
}

// MARK: - UITableView Delegate
extension WeatherViewController: UITableViewDelegate {}

extension WeatherViewController: UITableViewDataSource {
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

