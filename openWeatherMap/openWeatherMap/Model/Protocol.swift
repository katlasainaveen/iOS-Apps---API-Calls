//
//  Protocol.swift
//  Clima
//
//  Created by Sai Naveen Katla on 07/09/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagaerDelegate {
    func UpdateWeatherInfo(_ weathermanagaer: File, info: WeatherModel)
    func DidFailwITHeRROR(error: Error)
}
