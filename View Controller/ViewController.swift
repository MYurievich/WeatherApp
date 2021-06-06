//
//  ViewController.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.onCompletion = { currentWeather in
            self.presentCurrentWeather(currentWeather: currentWeather)
        }
    }

    @IBAction func searchButton(_ sender: UIButton) {
        presentAlertCotroller(title: "Search city", message: nil, style: .alert) { cityName in
            self.networkManager.fetchCurrentWeather(cityName: cityName)
        }
    }
    
    func presentCurrentWeather(currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.temperatureLabel.text = currentWeather.tempString
        }
    }
}

