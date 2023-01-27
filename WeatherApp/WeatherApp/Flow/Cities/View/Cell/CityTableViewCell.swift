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
    
    private let temp: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 30)
        lable.textColor = .red
        lable.numberOfLines = 1
        lable.backgroundColor = .clear
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

extension CityTableViewCell {
    
    // MARK: - Functions
    
    func setupCell(cityName: String, temp: String) {
        self.cityName.text = cityName
        self.temp.text = temp
    }
    
    // MARK: - Private Functions
    
    private func addSubViews() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(cityName)
        stackview.addArrangedSubview(temp)
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.spacing = 20
        stackview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
    }
}
