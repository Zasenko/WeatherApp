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
        stackview.backgroundColor = .orange
        return stackview
    }()
    
    private let cityName: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20)
        lable.numberOfLines = 0
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
        lable.textAlignment = .center
        lable.backgroundColor = .blue
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let addCityButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        stackview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        temp.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
