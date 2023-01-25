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
    var data: [String] = ["Москва", "Иркутск", "Вена", "Иркутск", "Вена", "Иркутск", "Вена", "Иркутск", "Вена", "Иркутск", "Вена"]
    var data2: [String] = ["15", "79", "28", "79", "28", "79", "28", "79", "28", "79", "28", "79", "28"]
    
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
        //navigationController?.title = "Cities"
        self.navigationController?.navigationItem.title = "Test"
           self.navigationController?.navigationBar.barTintColor = .black
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddCityButtonTaped(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
        
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
        rootView.citiesTableView.register(CityViewCell.self, forCellReuseIdentifier: CityViewCell.identifier)
    }
}

extension CitiesViewController {
    
    // MARK: - Private func
    
    private func addTargets() {
    }
    
    // MARK: - @Objc func
    
    @objc func AddCityButtonTaped(sender: UIButton) {
    }
}

// MARK: - TableViewDelegate

extension CitiesViewController: UITableViewDelegate {
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
            fatalError("Unabel to create cell")
        }
        cell.setupCell(cityName: data[indexPath.row], temp: data2[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellTaped(name: data[indexPath.row])
    }
}


extension CitiesViewController: CitiesViewProtocol {
    
}
