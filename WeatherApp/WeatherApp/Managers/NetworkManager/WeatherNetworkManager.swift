//
//  WeatherNetworkManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 28.01.23.
//

import Foundation
import CoreLocation

struct LocationWeather: Codable {
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
    }
    
    var currentWeather: Weather?
}

struct Weather: Codable {
    let temperature: Double
    let weathercode: Int
}

protocol WeatherNetworkManagerProtocol {
    func fetchCurrentWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<LocationWeather, Error>) -> Void)
}

class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    
    enum NetworkManagerErrors: Error {
        case decoderError
        case bedUrl
        case invalidStatusCode
    }
    
    let host = "api.open-meteo.com"
    let scheme = "https"
    
    func fetchCurrentWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<LocationWeather, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = "/v1/forecast"
        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "current_weather", value: "true")
        ]

        guard let url = urlComponents.url else {
            complition(.failure(NetworkManagerErrors.bedUrl))
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error, data != nil {
                complition(.failure(error))
                return
            }
            do {
                let weather = try JSONDecoder().decode(LocationWeather.self, from: data!)
                complition(.success(weather))
            } catch {
                complition(.failure(NetworkManagerErrors.decoderError))
            }
        }.resume()
    }
}
