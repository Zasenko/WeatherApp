//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

final class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: AddCityPresenterProtocol!
    
    // MARK: - Provate Properties
    
    private let rootView = AddCityRootView(frame: UIScreen.main.bounds)
    
    //MARK: - Inits
    
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
        self.title = "Add City"
        createNavigationBar()
        createAddCitiesTableView()
    }
}

// MARK: - ViewProtocol

extension AddCityViewController: AddCityViewProtocol {
    func reloadTableView() {
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
        cell.setupCell(cityName: "\(city.name), \(city.country)", isSaved: city.isSaved)
        cell.callback = { [weak self] in
            cell.addButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.1,
                                   delay: 0,
                                   options: .curveLinear,
                                   animations: { [weak self] in
                                        cell.addButton.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                    }) {  (done) in
                        UIView.animate(withDuration: 0.1,
                                       delay: 0,
                                       options: .curveLinear,
                                       animations: { [weak self] in
                            cell.addButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                        }) { [weak self] (_) in
                            cell.addButton.isUserInteractionEnabled = true
                        }
                    }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.presenter.addCityButtonTapped()
            }


        }
        return cell
    }
}

// MARK: - Private func

extension AddCityViewController {
    
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
