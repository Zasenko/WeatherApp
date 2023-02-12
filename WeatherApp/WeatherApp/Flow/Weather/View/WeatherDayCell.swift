//
//  WeatherDayCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 12.02.23.
//

import UIKit

final class WeatherDayCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let identifier = "WeatherDayCell"
    
    // MARK: - Private Properties
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
  //      imageView.backgroundColor = .green
        return imageView
    }()
    
    private let sunsetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImages.sunset
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let sunriseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImages.sunrise
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 17)
        lable.textColor = .white
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
    //    lable.backgroundColor = .red
        return lable
    }()
    
    private let minTemperatureLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 15)
        lable.textColor = .systemGray3
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
    //    lable.backgroundColor = .orange
        return lable
    }()
    
    private let sunriseLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 15)
        lable.textColor = .systemGray3
        lable.numberOfLines = 1
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let sunsetLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 15)
        lable.textColor = .systemGray3
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
     //   lable.backgroundColor = .green
        return lable
    }()
    
    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.translatesAutoresizingMaskIntoConstraints = false
    //    stackview.backgroundColor = .red
        return stackview
    }()
    
    private let weatherStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        stackview.translatesAutoresizingMaskIntoConstraints = false
     //   stackview.backgroundColor = .blue
        return stackview
    }()
    
    private let tempetateureStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .bottom
        stackview.distribution = .fillProportionally
        stackview.translatesAutoresizingMaskIntoConstraints = false
     //   stackview.backgroundColor = .systemGreen
        return stackview
    }()
    
    private let sunStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
    //    stackview.backgroundColor = .brown
        return stackview
    }()
    
    private let sunriseStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.alignment = .center
        stackview.translatesAutoresizingMaskIntoConstraints = false
     //   stackview.backgroundColor = .magenta
        return stackview
    }()
    
    private let sunsetStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.alignment = .center
        stackview.translatesAutoresizingMaskIntoConstraints = false
     //   stackview.backgroundColor = .purple
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
        weatherImage.image = nil
        sunsetImage.image = nil
        sunriseImage.image = nil
        maxTemperatureLabel.text = nil
        minTemperatureLabel.text = nil
        sunriseLabel.text = nil
        sunsetLabel.text = nil
        dateLable.text = nil
    }
}

extension WeatherDayCell {
    
    // MARK: - Functions

    func setupCell(madel: DayCellModel) {
        self.weatherImage.image = madel.img
        minTemperatureLabel.text = madel.tempMin
        maxTemperatureLabel.text = madel.tempMax
        sunsetLabel.text = madel.sunset
        sunriseLabel.text = madel.sunrise
        dateLable.text = madel.date
    }
    
    // MARK: - Private Functions
    
    private func addSubViews() {

        addSubview(stackview)
        
        stackview.addArrangedSubview(dateLable)
        stackview.addArrangedSubview(weatherStack)
        stackview.addArrangedSubview(sunStack)
        
        weatherStack.addArrangedSubview(weatherImage)
        weatherStack.addArrangedSubview(tempetateureStack)
        
        tempetateureStack.addArrangedSubview(minTemperatureLabel)
        tempetateureStack.addArrangedSubview(maxTemperatureLabel)
        
        sunStack.addArrangedSubview(sunriseStack)
        sunStack.addArrangedSubview(sunsetStack)
        
        sunriseStack.addArrangedSubview(sunriseImage)
        sunriseStack.addArrangedSubview(sunriseLabel)
        
        sunsetStack.addArrangedSubview(sunsetImage)
        sunsetStack.addArrangedSubview(sunsetLabel)
        
        
    }
    
    private func setupConstraints() {
        stackview.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        stackview.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true
        stackview.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        weatherStack.heightAnchor.constraint(equalTo: self.layoutMarginsGuide.heightAnchor).isActive = true
    }
}
