//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

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
                
      //  navigationController?.navigationBar.backgroundColor = .red // backgorund color with gradient
        // or
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.18, green: 0.77, blue: 0.79, alpha: 1.00)  // solid color
        
//        let bounds = self.navigationController?.navigationBar.bounds
//            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//            visualEffectView.frame = bounds ?? CGRect.zero
//            visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.navigationController?.navigationBar.addSubview(visualEffectView)
        
    //    navigationController?.navigationBar.barTintColor = UIColor.green
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityButtonTaped(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    private func createCitiesTableView() {
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
    }
}

// MARK: - TableViewDelegate

extension CitiesViewController: UITableViewDelegate {}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCitiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        // TODO - получение готовых данных
        
        let city = presenter.getCity(indexPath: indexPath.row)
        
        var tempString = ""
        if let temp = city.weather.currentWeather?.temperature {
            tempString = String(temp)
        }
        
        cell.setupCell(cityName: city.name, temp: tempString, currentWeatherImage: city.weather.currentWeather?.weathercode.image ?? UIImage())
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
