//
//  AddCityRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

final class AddCityRootView: UIView {

    
    // MARK: - SubViews
    
    let searchBar : UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    let citiesTableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = .zero
        tableView.backgroundColor = .purple
        return tableView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGreen
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddCityRootView {
    
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
