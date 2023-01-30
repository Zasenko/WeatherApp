//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 30.01.23.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "HourlyWeatherCell"
    
    // MARK: - Private Properties
    
    let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGray5])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 42)))
        imageView.preferredSymbolConfiguration = config
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20)
        lable.textColor = .blue
        lable.backgroundColor = .yellow
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let timeLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 15)
        lable.numberOfLines = 0
        lable.textAlignment = .left
        lable.backgroundColor = .yellow
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let stackview = UIStackView()
    
//    // MARK: - Inits
//    
//    override init(frame: CGRect) {
//        <#code#>
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .white
//        addSubViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

extension HourlyWeatherCell {
    
    // MARK: - Functions

    func setupCell(time: String, temperature: String, image: UIImage) {
        self.temperatureLabel.text = temperature
        self.timeLable.text = time
        self.weatherImage.image = image
    }
    
    // MARK: - Private Functions
    
    private func addSubViews() {
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(weatherImage)
        stackview.addArrangedSubview(temperatureLabel)
        stackview.addArrangedSubview(timeLable)
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
//        temp.widthAnchor.constraint(equalToConstant: 80).isActive = true
//
//        currentWeatherImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        currentWeatherImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
