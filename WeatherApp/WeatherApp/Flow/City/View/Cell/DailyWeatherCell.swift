//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 31.01.23.
//

import UIKit

final class DailyWeatherCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "DailyWeatherCell"
    
    // MARK: - Private Properties
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGray5])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        imageView.preferredSymbolConfiguration = config
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 20)
        lable.textColor = .white
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let minTemperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 17)
        lable.textColor = .white
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let sunriseLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 17)
        lable.textColor = .white
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let sunsetLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 17)
        lable.textColor = .white
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let dateLable: UILabel = {
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
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let weatherStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .equalCentering
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let tempetateureStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let sunStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
        //    self.accessoryType = .none
        }
}

extension DailyWeatherCell {
    
    // MARK: - Functions

    func setupCell(date: String, image: UIImage, maxMemperature: String, minTemperature: String, sunrise: String, sunset: String) {
        self.weatherImage.image = image
        minTemperatureLabel.text = minTemperature
        maxTemperatureLabel.text = maxMemperature
        sunsetLabel.text = sunset
        sunriseLabel.text = sunrise
        dateLable.text = date
    }
    
    // MARK: - Private Functions
    
    private func addSubViews() {
        tempetateureStack.addArrangedSubview(minTemperatureLabel)
        tempetateureStack.addArrangedSubview(maxTemperatureLabel)
        
        sunStack.addArrangedSubview(sunriseLabel)
        sunStack.addArrangedSubview(sunsetLabel)
        
        weatherStack.addArrangedSubview(weatherImage)
        weatherStack.addArrangedSubview(tempetateureStack)
        
        stackview.addArrangedSubview(dateLable)
        stackview.addArrangedSubview(weatherStack)
        stackview.addArrangedSubview(sunStack)
    
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        stackview.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        stackview.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor).isActive = true
        stackview.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor).isActive = true
        stackview.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
}
