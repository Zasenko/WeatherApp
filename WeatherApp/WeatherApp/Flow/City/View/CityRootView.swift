//
//  CityRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

final class CityRootView: UIView {
    
    let cellHeight = 80.0
    var tableViewHeight: NSLayoutConstraint?
    
    //MARK: - SubView
    
    let scrollView = UIScrollView()
    let contentView = UIView()

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
        lable.textColor = .white
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
        viewLayout.itemSize = CGSize(width: 80, height: 100)
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
    
    let dailyTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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

        dailyTableView.isScrollEnabled = false
        dailyTableView.showsVerticalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityRootView {
    
    //MARK: - Private Functions
    
    private func addSubViews() {
        contentView.addSubview(weatherImage)
        contentView.addSubview(temperatureLable)
        contentView.addSubview(hourlyLable)
        contentView.addSubview(hourlyCollectionView)
        contentView.addSubview(dailyLable)
        contentView.addSubview(dailyTableView)
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        temperatureLable.topAnchor.constraint(equalTo: weatherImage.bottomAnchor).isActive = true
        temperatureLable.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        temperatureLable.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        
        hourlyLable.topAnchor.constraint(equalTo: temperatureLable.bottomAnchor, constant: 20).isActive = true
        hourlyLable.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor).isActive = true
        hourlyLable.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        
        hourlyCollectionView.topAnchor.constraint(equalTo: hourlyLable.bottomAnchor).isActive = true
        hourlyCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hourlyCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hourlyCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        dailyLable.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 20).isActive = true
        dailyLable.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor).isActive = true
        dailyLable.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        
        dailyTableView.topAnchor.constraint(equalTo: dailyLable.bottomAnchor).isActive = true
        dailyTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        dailyTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        dailyTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        tableViewHeight = dailyTableView.heightAnchor.constraint(equalToConstant: 0)
            
        tableViewHeight?.isActive = true
    }
}
