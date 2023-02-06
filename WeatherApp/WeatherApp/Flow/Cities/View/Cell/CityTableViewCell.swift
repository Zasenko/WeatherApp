//
//  CityViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "CityTableViewCell"
    
    // MARK: - Private Properties
    
    private let stackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [])
        stackview.alignment = .center
        stackview.spacing = 20
        return stackview
    }()
    
    private let cityName: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20)
        lable.numberOfLines = 0
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let temp: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 30)
        lable.textColor = .black
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let currentWeatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityTableViewCell {
    
    // MARK: - Functions
    
    func setupCell(cityName: String, temp: String, currentWeatherImage: UIImage) {
        self.cityName.text = cityName
        self.temp.text = temp
        self.currentWeatherImage.image = currentWeatherImage
    }
    
    // MARK: - Private Functions
    
    private func addSubViews() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(cityName)
        stackview.addArrangedSubview(temp)
        stackview.addArrangedSubview(currentWeatherImage)
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor,constant: -20).isActive = true
        
        temp.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
        currentWeatherImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        currentWeatherImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
