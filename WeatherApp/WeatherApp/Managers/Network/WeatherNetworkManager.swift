//
//  WeatherNetworkManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 28.01.23.
//

import Foundation

protocol WeatherNetworkManagerProtocol {
    func fetchCurrentWeatherByLocation(latitude: String,
                                       longitude: String,
                                       complition: @escaping(Result<WeatherDecodedModel, Error>) -> Void)
    func fetchWeatherByLocation(latitude: String,
                                longitude: String,
                                complition: @escaping(Result<WeatherDecodedModel, Error>) -> Void)
    func fetchFullWeatherByLocation(latitude: String,
                                    longitude: String,
                                    complition: @escaping(Result<WeatherDecodedModel, Error>) -> Void)
}

final class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    
    enum NetworkManagerErrors: Error {
        case decoderError
        case bedUrl
    }
    
    let host = "api.open-meteo.com"
    let scheme = "https"
    
    func fetchCurrentWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<WeatherDecodedModel, Error>) -> Void) {
        DispatchQueue.global().async {
            var urlComponents = URLComponents()
            urlComponents.host = self.host
            urlComponents.scheme = self.scheme
            urlComponents.path = "/v1/forecast"
            urlComponents.queryItems = [
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitude),
                URLQueryItem(name: "current_weather", value: "true"),
                URLQueryItem(name: "timezone", value: "auto")
            ]
            
            guard let url = urlComponents.url else {
                DispatchQueue.main.async {
                    complition(.failure(NetworkManagerErrors.bedUrl))
                }
                return
            }
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error, data != nil {
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                    return
                }
                do {
                    let weather = try JSONDecoder().decode(WeatherDecodedModel.self, from: data!)
                    DispatchQueue.main.async {
                        complition(.success(weather))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(NetworkManagerErrors.decoderError))
                    }
                }
            }.resume()
        }
    }
    
    func fetchWeatherByLocation(latitude: String,
                                longitude: String,
                                complition: @escaping(Result<WeatherDecodedModel, Error>) -> Void) {
        DispatchQueue.global().async {
            var urlComponents = URLComponents()
            urlComponents.host = self.host
            urlComponents.scheme = self.scheme
            urlComponents.path = "/v1/forecast"
            urlComponents.queryItems = [
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitude),
                URLQueryItem(name: "hourly", value: "temperature_2m,weathercode"),
                URLQueryItem(name: "daily", value: "weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset"),
                URLQueryItem(name: "timezone", value: "auto")
            ]
            
            guard let url = urlComponents.url else {
                DispatchQueue.main.async {
                    complition(.failure(NetworkManagerErrors.bedUrl))
                }
                return
            }
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error, data != nil {
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                    return
                }
                do {
                    let weather = try JSONDecoder().decode(WeatherDecodedModel.self, from: data!)
                    DispatchQueue.main.async {
                        complition(.success(weather))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(NetworkManagerErrors.decoderError))
                    }
                }
            }.resume()
        }
    }
    
    func fetchFullWeatherByLocation(latitude: String, longitude: String, complition: @escaping(Result<WeatherDecodedModel, Error>) -> Void) {
        DispatchQueue.global().async {
            var urlComponents = URLComponents()
            urlComponents.host = self.host
            urlComponents.scheme = self.scheme
            urlComponents.path = "/v1/forecast"
            urlComponents.queryItems = [
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitude),
                URLQueryItem(name: "current_weather", value: "true"),
                URLQueryItem(name: "hourly", value: "temperature_2m,weathercode"),
                URLQueryItem(name: "daily", value: "weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset"),
                URLQueryItem(name: "timezone", value: "auto")
            ]
            
            guard let url = urlComponents.url else {
                DispatchQueue.main.async {
                    complition(.failure(NetworkManagerErrors.bedUrl))
                }
                return
            }
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error, data != nil {
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                    return
                }
                do {
                    let weather = try JSONDecoder().decode(WeatherDecodedModel.self, from: data!)
                    DispatchQueue.main.async {
                        complition(.success(weather))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(NetworkManagerErrors.decoderError))
                    }
                }
            }.resume()
        }
        
    }
}
