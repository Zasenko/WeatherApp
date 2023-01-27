//
//  AddCityTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

class AddCityTableViewCell: UITableViewCell {

    // MARK: - Static properties
    
    static let identifier = "AddCityTableViewCell"
    
    // MARK: - Private properties
    
    private let stackview = UIStackView(arrangedSubviews: [])
    
    private let cityName: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 20)
        lable.numberOfLines = 0
        lable.textAlignment = .left
        lable.backgroundColor = .yellow
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    let addCityButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddCityTableViewCell {
    
    // MARK: - Functions
    
    func setupCell(cityName: String) {
        self.cityName.text = cityName
    }
    
    // MARK: - Private functions
    
    private func addSubViews() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(cityName)
        stackview.addArrangedSubview(addCityButton)
        stackview.backgroundColor = .orange
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}
