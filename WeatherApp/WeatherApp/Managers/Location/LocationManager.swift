//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 01.02.23.
//

import CoreLocation

protocol LocationManagerProtocol {
    var delegate: LocationManagerDelegate? { get set }
    func getUserLocation()
}

protocol LocationManagerDelegate: AnyObject {
    func reloadUserLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

final class LocationManager: NSObject {
        
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    weak var delegate: LocationManagerDelegate?
        
    override init() {
        super.init()
    }
}

extension LocationManager: LocationManagerProtocol {
    func getUserLocation() {
        configureLocationManager()
    }
}

// MARK: - Private Functions
extension LocationManager {
    private func configureLocationManager() {
       
        //locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        locationManager.delegate = self
        checkLocationAutorization()
    }
}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAutorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        userLocation = location
        locationManager.stopUpdatingLocation()
        DispatchQueue.main.async {
            self.delegate?.reloadUserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension LocationManager {

    //MARK: - Private functions

    private func checkLocationAutorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("checkLocationAutorization - .restricted, .denied")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}
