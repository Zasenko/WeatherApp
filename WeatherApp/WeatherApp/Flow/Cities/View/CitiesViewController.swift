//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CitiesViewPresenterProtocol!
    
    // MARK: - Private properties
    
    private let rootView = CitiesViewControllerRootView(frame: UIScreen.main.bounds)

    // MARK: - Inits
    
    init() {
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
        navigationController?.navigationBar.barTintColor = .systemTeal

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityButtonTaped(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    private func createCitiesTableView() {
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
        rootView.citiesTableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
}

extension CitiesViewController: AddCityViewControllerProtocol {
    func addedCity(city: GeoCodingCityModel) {
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

        let city = presenter.cities[indexPath.row]
        var string = ""
        var img = UIImage()
        if let currentWeather = city.currentWeather {
            string = String(currentWeather.temperature)
            img = currentWeather.weathercode.image
        }
        
        cell.setupCell(cityName: city.name, temp: string, currentWeatherImage: img)
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellTaped(name: presenter.cities[indexPath.row].name)
    }
}


extension CitiesViewController: CitiesViewProtocol {
    func reloadTableView() {
        rootView.citiesTableView.reloadData()
    }
}
