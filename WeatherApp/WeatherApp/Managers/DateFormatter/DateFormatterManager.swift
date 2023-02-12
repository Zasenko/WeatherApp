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
    var hourFormat: DateFormatter { get set }
    var hourAndMinFormat: DateFormatter { get set }
    var monthAndDay: DateFormatter { get set }
    var dayCellFormat: DateFormatter { get set }
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
    
    var dayCellFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter
    }()
    
    var hourFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    var hourAndMinFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var monthAndDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter
    }()
}
