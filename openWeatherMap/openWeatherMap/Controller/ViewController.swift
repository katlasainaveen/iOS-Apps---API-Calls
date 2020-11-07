//
//  ViewController.swift
//  openWeatherMap
//
//  Created by Sai Naveen Katla on 07/09/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextView: UITextField!
    @IBOutlet weak var currentLocationBtn: UIButton!
    
    var manager = File()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        searchTextView.delegate = self
        manager.delegate = self
        locationManager.requestLocation()
        
    }
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextView.endEditing(true)
    }
    
    func alertMessaage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (aler) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    


}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagaerDelegate {
    
    func UpdateWeatherInfo(_ weathermanagaer: File,info: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: info.conditionName)
            self.temperatureLabel.text = info.tempString
            self.cityLabel.text = info.cityname
        }
        
    }
    
    func DidFailwITHeRROR(error: Error) {
        print(error)
    }
}

//MARK: - UITextfieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextView.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextView.text == "" {
            searchTextView.placeholder = "Type Something"
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextView.placeholder = "Search"
        
        if let city = searchTextView.text {
            manager.fetch(city: city)
        }
        
        searchTextView.text = ""
    }
    
}

//MARK: - Location Update

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ managere: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            manager.fetch(latitude: lat, longitude: lon)
            print(lat)
            print(lon)
        }
    }
    
    func checkStatus() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("here")
            locationManager.requestWhenInUseAuthorization()
            return false
        case .authorizedWhenInUse:
            return true
        case .authorizedAlways:
            return true
        case .restricted:
            return false
        case .denied:
            return false
        default:
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let check = checkStatus()
        if check == false {
            alertMessaage(title: "Location Access Denied", message: "Settings > Privact > Location Services > Clima > While Using the App")
        }
        print(error.localizedDescription)
    }
}

