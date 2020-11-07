//
//  WeatherModel.swift
//  Clima
//
//  Created by Sai Naveen Katla on 07/09/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id: Int
    let cityname: String
    let temp: Double
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "wind.snow"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
    
}
