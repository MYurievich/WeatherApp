//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import Foundation


struct CurrentWeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String

}

struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
