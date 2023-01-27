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
    var data: [String] = ["Стамбул", "Vienna Vienna Vienna Vienna Vienna", "Иркутск", "Вена", "Милан"]
    var data2: [String] = ["14", "79", "-17", "79", "28"]
    
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
    
    @objc func AddCityButtonTaped(sender: UIButton) {
        presenter.addButtonTapped()
    }
    
    // MARK: - Private func
    
    private func createNavigationBar() {
        self.title = "Cities"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemTeal

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddCityButtonTaped(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    private func createCitiesTableView() {
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
        rootView.citiesTableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
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
