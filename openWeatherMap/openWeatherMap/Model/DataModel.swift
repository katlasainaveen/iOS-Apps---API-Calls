//
//  DataModel.swift
//  Clima
//
//  Created by Sai Naveen Katla on 07/09/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct DataModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
