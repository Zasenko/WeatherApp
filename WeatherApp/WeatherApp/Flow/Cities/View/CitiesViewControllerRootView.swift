//
//  CitiesViewControllerRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

class CitiesViewControllerRootView: UIView {
    
    // MARK: - SubViews
    
    let citiesTableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = .zero
        tableView.backgroundColor = .brown
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
        addSubViews()
        setupConstraints()
    }
}

extension CitiesViewControllerRootView {
    
    //MARK: - Private Functions

    private func addSubViews() {
        addSubview(citiesTableView)
    }
    
    private func setupConstraints() {
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        citiesTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        citiesTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        citiesTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        citiesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
