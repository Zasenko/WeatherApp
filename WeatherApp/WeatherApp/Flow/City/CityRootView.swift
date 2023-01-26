//
//  CityRootView.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

class CityRootView: UIView {

    //MARK: - SubView
    
    let appNameLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 40)
        lable.textAlignment = .center
        lable.numberOfLines = 1
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
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
        addSubview(appNameLable)
    }
    
    private func setupConstraints() {
        createAppNameLableConstraint()
    }
    
    private func createAppNameLableConstraint() {
        appNameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        appNameLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        appNameLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}
