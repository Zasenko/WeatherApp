//
//  GeoCodingManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 27.01.23.
//

import Foundation
import CoreLocation

class GeoCodingManager {
    
    // MARK: - Private properties
    private let geocoder = CLGeocoder()
}

extension GeoCodingManager {

    // MARK: - Functions
    
    func findCity(address: String, complition: @escaping (GeoCodingCityModel?) -> Void) {
        
        geocoder.geocodeAddressString(address, completionHandler: { placemarks, error in
            if (error != nil) {
                complition(nil)
                return
            }
            
            guard let placemark = placemarks?.first,
                  let coordinate = placemark.location?.coordinate,
                  let name = placemark.name,
                  let country = placemark.country
            else {
                complition(nil)
                return
            }

            let city = GeoCodingCityModel(coordinate: coordinate, name: name, country: country)
            DispatchQueue.main.async {
                complition(city)
            }
        })
    }
}
