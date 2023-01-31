//
//  WeatherNetworkManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 28.01.23.
//

import Foundation
import CoreLocation

struct WeatherDecodedModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        case hourly, daily
    }
    
    var currentWeather: Weather?
    var hourly: HourlyWeatherDecodedModel?
    var daily: DailyWeatherDecidedModel?
}

struct Weather: Codable {
    let temperature: Double
    let weathercode: Int
}

struct HourlyWeatherDecodedModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weathercode
    }
    
    var time: [String]
    var temperature: [Double]
    var weathercode: [Int]
}

struct DailyWeatherDecidedModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case time
        case weathercode
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    var time: [String]
    var weathercode: [Int]
    var temperatureMax: [Double]
    var temperatureMin: [Double]
    var sunrise: [String]
    var sunset: [String]
}

protocol WeatherNetworkManagerProtocol {
    func fetchCurrentWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<WeatherDecodedModel, Error>) -> Void)
    
    func fetchWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<WeatherDecodedModel, Error>) -> Void)
}

class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    
    enum NetworkManagerErrors: Error {
        case decoderError
        case bedUrl
    }
    
    let host = "api.open-meteo.com"
    let scheme = "https"
    
    func fetchCurrentWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<WeatherDecodedModel, Error>) -> Void) {
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
                let weather = try JSONDecoder().decode(WeatherDecodedModel.self, from: data!)
                complition(.success(weather))
            } catch {
                complition(.failure(NetworkManagerErrors.decoderError))
            }
        }.resume()
    }
    
    func fetchWeatherByLocation(latitude: String, longitude: String, complition: @escaping (Result<WeatherDecodedModel, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = "/v1/forecast"
        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "hourly", value: "temperature_2m,weathercode"),
            URLQueryItem(name: "daily", value: "weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset"),
            URLQueryItem(name: "timezone", value: "GMT")
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
                let weather = try JSONDecoder().decode(WeatherDecodedModel.self, from: data!)
                complition(.success(weather))
            } catch {
                complition(.failure(NetworkManagerErrors.decoderError))
            }
        }.resume()
    }
    
}
