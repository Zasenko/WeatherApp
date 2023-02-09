//
//  DateFormatterManager.swift
//  WeatherApp
//
//  Created by Dmitry Zasenko on 07.02.23.
//

import Foundation

protocol DateFormatterManagerProtocol {
    var fullFormat: DateFormatter { get set }
    var dayFormat: DateFormatter { get set }
}

final class DateFormatterManager: DateFormatterManagerProtocol {
    var fullFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return formatter
    }()
    
    var dayFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
