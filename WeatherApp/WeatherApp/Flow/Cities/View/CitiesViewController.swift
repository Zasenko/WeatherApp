//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

class CitiesViewController: UIViewController {
    
    
    var data: [String] = ["Москва", "Иркутск", "Вена"]
    var data2: [String] = ["15", "79", "28"]
    
    private let rootView = CitiesViewControllerRootView(frame: UIScreen.main.bounds)

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
        rootView.citiesTableView.register(CityViewCell.self, forCellReuseIdentifier: CityViewCell.identifier)
        rootView.citiesTableView.nav
    }
}

extension CitiesViewController {
    
    // MARK: - Private func
    
    private func addTargets() {
    }
    
    // MARK: - @Objc func
    
    @objc func buttonTaped(sender: UIButton) {
        print("UIiiiiiiiiiii")
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
}
