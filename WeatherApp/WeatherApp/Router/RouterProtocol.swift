//
//  RouterProtocol.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 25.01.23.
//

import UIKit

protocol AbstractRouterProtocol {
    var navigationController:  UINavigationController? { get set }
    var modulBilder: ModulBilderProtocol? { get set }
}
