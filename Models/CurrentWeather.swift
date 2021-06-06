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
        return "\(temp)"
    }
    
    init?(cityName: String, temp: Double) {
        self.cityName = cityName
        self.temp = temp
    }
}
