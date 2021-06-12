//
//  ViewController+AlertController.swift
//  WeatherApp
//
//  Created by Максим on 06.06.2021.
//

import UIKit
import CoreLocation

extension ViewController {
    func presentAlertCotroller(title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let arrayRandomCity = ["Saint Petersburg", "Moscow", "Ukhta"]
            tf.placeholder = arrayRandomCity.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { _ in
            let textField = ac.textFields?.first
            guard let city = textField?.text else { return }
            if city != "" {
                let cityName = city.split(separator: " ").joined(separator: "%20")
                completionHandler(cityName)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        networkManager.fetchCurrentWeather(requestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
