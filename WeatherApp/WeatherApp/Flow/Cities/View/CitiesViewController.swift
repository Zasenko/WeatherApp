//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol AddCityViewControllerProtocol: AnyObject {
    func addedCity(city: CityModel)
}

final class CitiesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: CitiesViewPresenterProtocol
    
    // MARK: - Private properties
    
    private let rootView = CitiesViewControllerRootView(frame: UIScreen.main.bounds)

    // MARK: - Inits
    
    init(presenter: CitiesViewPresenterProtocol) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        createCitiesTableView()
    }
}

extension CitiesViewController {
    
    // MARK: - @Objc func
    
    @objc func addCityButtonTaped(sender: UIButton) {
        presenter.addButtonTapped()
    }
    
    // MARK: - Private func
    
    private func createNavigationBar() {
        self.title = "Cities"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .yellow

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityButtonTaped(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    private func createCitiesTableView() {
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
    }
}

extension CitiesViewController: AddCityViewControllerProtocol {
    func addedCity(city: CityModel) {
        presenter.addNewCity(city: city)
    }
}

// MARK: - TableViewDelegate

extension CitiesViewController: UITableViewDelegate {}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        // TODO - получение готовых данных
        
        let city = presenter.cities[indexPath.row]
        cell.setupCell(cityName: city.name, temp: String(city.weather.currentWeather?.temperature ?? 0) , currentWeatherImage: city.weather.currentWeather?.weathercode.image ?? UIImage())
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellTaped(indexPath: indexPath)
    }
}

extension CitiesViewController: CitiesViewProtocol {
    func reloadTableView() {
        rootView.citiesTableView.reloadData()
    }
}
