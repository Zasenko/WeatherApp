//
//  AddCityTableViewCell.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

class AddCityTableViewCell: UITableViewCell {

    // MARK: - Static properties
    
    static let identifier = "AddCityTableViewCell"
    
    // MARK: - Properties
    
    var callback: () -> () = {}
    
    // MARK: - Private properties
    
    private let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = .systemPink
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .systemPink
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func setupCell(cityName: String) {
        label.text = cityName
    }
    
    // MARK: - Objc Functions
    
    @objc func didTapButton(sender: UIButton) {
        callback()
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
        addButton.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    private func setupLableConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
    }
}
