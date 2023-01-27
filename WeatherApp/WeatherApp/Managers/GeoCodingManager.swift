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
    
    func findCity(address: String, complition: @escaping ([String]?) -> Void) {
        
        geocoder.geocodeAddressString(address, completionHandler: { placemarks, error in
            if (error != nil) {
                complition(nil)
                return
            }
            
            guard let placemarks = placemarks else {
                complition(nil)
                return
            }
            var data = [String]()
                for i in placemarks {
                    let lat = String(format: "%.04f", (i.location?.coordinate.longitude ?? 0.0)!)
                    let lon = String(format: "%.04f", (i.location?.coordinate.latitude ?? 0.0)!)
                    let name = i.name ?? ""
                    let country = i.country ?? ""
                    let region = i.administrativeArea ?? ""
                    data.append("\(lon), \(lat)\n\(name), \(region), \(country)")
                }
            DispatchQueue.main.async {
                complition(data)
            }
            
        })
    }
}
