//
//  WeatherData.swift
//  
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

struct WeatherData: Decodable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct CurrentWeather: Decodable {
    let lastUpdatedDateString: String
    let lastUpdatedDateTimestamp: Double
    let temperatureCelsius: Double
    let temperatureFahrenheit: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedDateString = "last_updated"
        case lastUpdatedDateTimestamp = "last_updated_epoch"
        case temperatureCelsius = "temp_c"
        case temperatureFahrenheit = "temp_f"
    }
}


struct Location: Decodable {
    let name: String
    let country: String
}
