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
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        var config = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGray5])
//        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 42)))
//        imageView.preferredSymbolConfiguration = config
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20)
        lable.textColor = .white
      //  lable.backgroundColor = .red
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let timeLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14)
        lable.numberOfLines = 0
        lable.textAlignment = .left
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        stackview.addArrangedSubview(timeLable)
        stackview.addArrangedSubview(weatherImage)
        stackview.addArrangedSubview(temperatureLabel)
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackview.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
