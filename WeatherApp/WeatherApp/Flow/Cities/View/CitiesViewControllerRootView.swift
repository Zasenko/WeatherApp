//
//  CitiesViewControllerRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

final class CitiesViewControllerRootView: UIView {
    
    // MARK: - SubViews
    
    let citiesTableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.rowHeight = 70
        return tableView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(red: 0.18, green: 0.77, blue: 0.79, alpha: 1.00).cgColor, UIColor(red: 0.19, green: 0.26, blue: 0.52, alpha: 1.00).cgColor]

        self.layer.insertSublayer(gradient, at: 0)
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
