//
//  AddCityTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

class AddCityTableViewCell: UITableViewCell {

    static let identifier = "AddCityTableViewCell"
    
    private let stackview = UIStackView(arrangedSubviews: [])
    
    private let cityName: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 20)
        lable.numberOfLines = 1
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
    
    func setupCell(cityName: String) {
        self.cityName.text = cityName
    }
    
    private func addSubViews() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(cityName)
        stackview.addArrangedSubview(addCityButton)
        stackview.backgroundColor = .orange
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.spacing = 20
        stackview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackview.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
//    func setupCell(cityName: String) {
//        self.cityName.text = cityName
//    }
//
}
