//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temp: Double
    var tempString: String {
        return String(format: "%0.1f", temp)
    }
    let id: Int
    
    init?(currentWeather: CurrentWeatherData) {
        cityName = currentWeather.name
        temp = currentWeather.main.temp
        id = currentWeather.weather.first!.id
    }
    
    var iconWeather: String {
        switch id {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.heavyrain"
        case 500...504: return "cloud.sun.rain"
        case 511: return "snow"
        case 520...531: return "cloud.moon.rain"
        case 600...622: return "snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801: return "cloud.sun"
        case 802: return "cloud"
        case 803...804: return "smoke"
        default:
            return "nosign"
        }
    }
    
}
