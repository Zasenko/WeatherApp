//
//  GeoCodingManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 27.01.23.
//

import CoreLocation

protocol GeoCodingManagerProtocol {
    func findCity(address: String, complition: @escaping (CityModel?) -> Void)
}

class GeoCodingManager {
    
    // MARK: - Private properties
    
    private let geocoder = CLGeocoder()
}

extension GeoCodingManager: GeoCodingManagerProtocol {

    // MARK: - Functions
    
    func findCity(address: String, complition: @escaping (CityModel?) -> Void) {
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

            let city = CityModel(coordinate: coordinate, name: name, country: country, weather: Weathers())
            DispatchQueue.main.async {
                complition(city)
            }
        })
    }
}
