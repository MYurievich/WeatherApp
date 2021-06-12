//
//  ViewController.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var networkManager = NetworkManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.onCompletion = { [unowned self] currentWeather in
            self.presentCurrentWeather(currentWeather: currentWeather)
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

    @IBAction func searchButton(_ sender: UIButton) {
        presentAlertCotroller(title: "Search city", message: nil, style: .alert) { [weak self] cityName in
            guard let self = self else { return }
            self.networkManager.fetchCurrentWeather(requestType: .cityName(city: cityName))
        }
    }
    
    func presentCurrentWeather(currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.temperatureLabel.text = currentWeather.tempString
            self.iconView.image = UIImage(systemName: currentWeather.iconWeather)
        }
    }
}

