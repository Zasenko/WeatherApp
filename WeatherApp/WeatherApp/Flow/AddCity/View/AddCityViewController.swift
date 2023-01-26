//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

class AddCityViewController: UIViewController {
    
    var data: [String] = ["иркутск", "новороссийск", "Иркутск", "Вена", "Милан"]
    var data2: [String] = ["17", "19", "-17", "-19", "0"]
    
    private let rootView = AddCityRootView(frame: UIScreen.main.bounds)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Bla bla"
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

extension AddCityViewController {
    
     // MARK: - @Objc func
    
    @objc func AddCityButtonTaped(sender: UIButton) {
     //   presenter.addButtonTapped()
        print("oooooooo")
    }
    
    // MARK: - Private func
    
    private func createNavigationBar() {
        self.title = "Cities"
        navigationItem.titleView = rootView.searchBar
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.barTintColor = .systemTeal
//
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        
//        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddCityButtonTaped(sender:)))
//        self.navigationItem.rightBarButtonItem  = button1
    }
    
    private func createCitiesTableView() {
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
        rootView.citiesTableView.register(CityViewCell.self, forCellReuseIdentifier: CityViewCell.identifier)
    }
}
extension AddCityViewController: UITableViewDelegate {}

extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(cityName: data[indexPath.row], temp: data2[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   presenter.cellTaped(name: data[indexPath.row])
    }
}
