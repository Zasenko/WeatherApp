//
//  CityModel.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 27.01.23.
//

import Foundation
import CoreLocation

struct CityModel {
    let coordinate: CLLocationCoordinate2D
    let name: String
    let country: String
    
    var weather: WeathersModel
}
