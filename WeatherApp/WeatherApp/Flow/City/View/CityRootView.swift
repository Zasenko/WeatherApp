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
        imageView.contentMode = .scaleAspectFit
        
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGray5])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100)))
        imageView.preferredSymbolConfiguration = config
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var temperatureLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 100)
        lable.textAlignment = .center
        lable.numberOfLines = 1
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let hourlyLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 16)
        lable.textAlignment = .center
        lable.text = "Hourly"
        lable.numberOfLines = 1
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let hourlyCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        viewLayout.itemSize = CGSize(width: 50, height: 150)
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .darkGray
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
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
    }
    
    private func setupConstraints() {
        weatherImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        temperatureLable.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 20).isActive = true
        temperatureLable.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        temperatureLable.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true
        
        hourlyLable.topAnchor.constraint(equalTo: temperatureLable.bottomAnchor, constant: 20).isActive = true
        hourlyLable.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        hourlyLable.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true
        
        hourlyCollectionView.topAnchor.constraint(equalTo: temperatureLable.bottomAnchor, constant: 10).isActive = true
        hourlyCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        hourlyCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        hourlyCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
}
