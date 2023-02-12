//
//  WeatherHourCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 12.02.23.
//

import UIKit

final class WeatherHourCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "WeatherHourCell"
    
    // MARK: - Private Properties
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 17, weight: .light)
        lable.textColor = .white
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let timeLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .thin)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherImage.image = nil
        temperatureLabel.text = nil
        timeLable.text = nil
    }
}

extension WeatherHourCell {
    
    // MARK: - Functions

    func setupCell(model: HourCellModel) {
        self.temperatureLabel.text = model.temp
        self.timeLable.text = model.hour
        self.weatherImage.image = model.img
        self.tintColor = .white
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
