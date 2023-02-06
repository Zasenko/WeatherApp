//
//  CityRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

final class CityRootView: UIView {

    //MARK: - SubView
    
    let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var temperatureLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 100, weight: .medium)
        lable.textAlignment = .center
        lable.numberOfLines = 1
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let hourlyLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 17)
        lable.textAlignment = .left
        lable.text = "Hourly"
        lable.numberOfLines = 1
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let hourlyCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        viewLayout.itemSize = CGSize(width: 60, height: 100)
        viewLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.identifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dailyLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 17)
        lable.textAlignment = .left
        lable.text = "Daily"
        lable.numberOfLines = 1
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let dailyCollectionView: UICollectionView = {
        
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        viewLayout.itemSize = CGSize(width: 150, height: 150)
        viewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(red: 0.18, green: 0.77, blue: 0.79, alpha: 1.00).cgColor, UIColor(red: 0.19, green: 0.26, blue: 0.52, alpha: 1.00).cgColor]

        self.layer.insertSublayer(gradient, at: 0)
        
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityRootView {
    
    //MARK: - Private Functions
    
    private func addSubViews() {
        addSubview(weatherImage)
        addSubview(temperatureLable)
        addSubview(hourlyLable)
        addSubview(hourlyCollectionView)
        addSubview(dailyLable)
        addSubview(dailyCollectionView)
    }
    
    private func setupConstraints() {
        
        weatherImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        temperatureLable.topAnchor.constraint(lessThanOrEqualTo: weatherImage.bottomAnchor).isActive = true
        temperatureLable.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        temperatureLable.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true

        hourlyLable.topAnchor.constraint(greaterThanOrEqualTo: temperatureLable.bottomAnchor, constant: 20).isActive = true
        hourlyLable.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        hourlyLable.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true

        hourlyCollectionView.topAnchor.constraint(equalTo: hourlyLable.bottomAnchor).isActive = true
        hourlyCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        hourlyCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        hourlyCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        dailyLable.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 20).isActive = true
        dailyLable.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        dailyLable.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true

        dailyCollectionView.topAnchor.constraint(equalTo: dailyLable.bottomAnchor).isActive = true
        dailyCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dailyCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dailyCollectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        dailyCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
