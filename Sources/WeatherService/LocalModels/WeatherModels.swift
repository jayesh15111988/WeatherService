//
//  WeatherModels.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

public struct WSWeatherData {
    let location: Location
    let currentTemperature: WSCurrentTemperature
    let forecasts: [TemperatureForecast]

    struct Location {
        let name: String
        let country: String
    }

    struct TemperatureForecast {
        let dateTimestamp: Double
        let dateString: String
        let maximumTemperatureCelsius: Double
        let maximumTemperatureFahrenheit: Double
        let minimumTemperatureCelsius: Double
        let minimumTemperatureFahrenheit: Double
        let averageTemperatureCelsius: Double
        let averageTemperatureFahrenheit: Double
    }
}

public struct WSCurrentTemperature {
    let temperatureCelsius: Double
    let temperatureFahrenheit: Double
    let lastUpdateDateTimestamp: Double
    let lastUpdateDateTimeString: String
}

public struct WSCurrentWeatherData {
    let location: Location
    let temperature: WSCurrentTemperature
}
