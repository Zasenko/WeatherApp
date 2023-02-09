//
//  AddCityTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

final class AddCityTableViewCell: UITableViewCell {

    // MARK: - Static properties
    
    static let identifier = "AddCityTableViewCell"
    
    // MARK: - Properties
    
    var callback: (() -> Void)?
    
    // MARK: - Private properties
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        
        button.setTitle("Added", for: .disabled)
        button.setTitleColor(.gray, for: .disabled)
        
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.buttonSize = .mini
        config.background.backgroundColor = .clear
        config.background.strokeWidth = 1
        
        button.configuration = config
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubViews()
        addTargets()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddCityTableViewCell {
    
    // MARK: - Functions
    
    func setupCell(cityName: String, isSaved: Bool) {
        label.text = cityName
        if isSaved {
            addButton.isEnabled = false
            addButton.configuration?.background.strokeColor = .gray
        } else {
            addButton.isEnabled = true
            addButton.configuration?.background.strokeColor = .yellow
        }
    }
    
    // MARK: - Objc Functions
    
    @objc func didTapButton(sender: UIButton) {
        callback?()
    }

    // MARK: - Private functions

    private func addSubViews() {
        contentView.addSubview(addButton)
        contentView.addSubview(label)
    }
    
    private func addTargets() {
        addButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
    }
    
    // MARK: - Constrsaints
    
    private func setupConstraints() {
        setupAddButtonConstraints()
        setupLableConstraints()
    }
    
    private func setupAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
      //  addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor).isActive = true
        addButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
    }
    
    private func setupLableConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.topAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
