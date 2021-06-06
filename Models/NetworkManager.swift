//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import Foundation

class NetworkManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(cityName: String) {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=de73a530cdd6fc71b468b36dbf78d796&units=metric"
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
