//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

final class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    
    let presenter: AddCityPresenterProtocol
    
    // MARK: - Provate Properties
    
    private let rootView = AddCityRootView(frame: UIScreen.main.bounds)
    
    //MARK: - Inits
    
    init(presenter: AddCityPresenterProtocol) {
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
        self.title = "Add City"
        createNavigationBar()
        createAddCitiesTableView()
    }
}

extension AddCityViewController {
    
    // MARK: - Private func
    
    private func createNavigationBar() {
        rootView.searchBar.delegate = self
        navigationItem.titleView = rootView.searchBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .purple
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func createAddCitiesTableView() {
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
    }
}

// MARK: - ViewProtocol

extension AddCityViewController: AddCityViewProtocol {
    func reloadAddButton() {
        //
    }
    
    func showFindedLocations() {
        rootView.citiesTableView.reloadData()
    }
}

// MARK: - SearchBarDelegate

extension AddCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchLocationByName(name: searchText)
    }
}

// MARK: - UITableViewDelegate

extension AddCityViewController: UITableViewDelegate {}

extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getCityCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCityTableViewCell.identifier, for: indexPath) as? AddCityTableViewCell else {
            return UITableViewCell()
        }
        guard let city = presenter.getCity() else {
            return UITableViewCell()
        }
        cell.setupCell(cityName: "\(city.name), \(city.country)")
        cell.callback = { [weak self] in
            guard let self = self else { return }
            self.presenter.addCityButtonTapped(city: city)
        }
        return cell
    }
}
