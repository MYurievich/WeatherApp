//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city): urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=de73a530cdd6fc71b468b36dbf78d796&units=metric"
        case .coordinate(let latitude, let longitude): urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=de73a530cdd6fc71b468b36dbf78d796&units=metric"
        }
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let data = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(data: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        data.resume()
    }
    
    func parseJSON(data: Data)->CurrentWeather? {
        let decoder = JSONDecoder()
        do {
        let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
        guard let currentWeather = CurrentWeather(currentWeather: currentWeatherData) else { return nil}
        return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
}
}
