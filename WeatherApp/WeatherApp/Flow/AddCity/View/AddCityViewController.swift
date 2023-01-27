//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 26.01.23.
//

import UIKit

final class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    
    var data: [String] = []
    var presenter: AddCityPresenterProtocol!
    
    // MARK: - Provate Properties
    
    private let rootView = AddCityRootView(frame: UIScreen.main.bounds)
    
    //MARK: - Inits
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life func
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add City"
        createNavigationBar()
        createAddCitiesTableView()
        addKeyboardTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddCityViewController {
    
    // MARK: - Objc functions
    
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        rootView.citiesTableView.contentInset = contentInsets
        rootView.citiesTableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        rootView.citiesTableView.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        rootView.citiesTableView.endEditing(true)
    }
    
    // MARK: - Private func
    
    private func addKeyboardTargets() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        rootView.citiesTableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    private func createNavigationBar() {
        navigationItem.titleView = rootView.searchBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .purple
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func createAddCitiesTableView() {
        rootView.searchBar.delegate = self
        rootView.citiesTableView.delegate = self
        rootView.citiesTableView.dataSource = self
    }
}

// MARK: - ViewProtocol

extension AddCityViewController: AddCityViewProtocol {
    func showFindedLocations() {
        rootView.citiesTableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension AddCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchLocationByName(name: searchText)
    }
}

// MARK: - UITableViewDelegate

extension AddCityViewController: UITableViewDelegate {}

extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       presenter.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCityTableViewCell.identifier, for: indexPath) as? AddCityTableViewCell else {
            return UITableViewCell()
        }
        guard let data = presenter.data?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setupCell(cityName: data)
        cell.callback = {
            cell.backgroundColor = .blue
        }
        return cell
    }
}
