//
//  CityViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

class CityViewCell: UITableViewCell {
    
    static let identifier = "CityViewCell"
    
    private let cityName: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 20)
        lable.numberOfLines = 1
        lable.backgroundColor = .clear
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let temp: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20)
        lable.numberOfLines = 1
        lable.backgroundColor = .clear
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        addSubViews()
        setupConstraints()
    }

    func setupCell(cityName: String, temp: String) {
        self.cityName.text = cityName
        self.temp.text = temp
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

extension CityViewCell {
    
    private func addSubViews() {
        addSubview(cityName)
        addSubview(temp)
    }
    
    private func setupConstraints() {
        cityName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cityName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cityName.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        cityName.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        cityName.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
