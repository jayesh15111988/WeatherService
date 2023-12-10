//
//  WeatherModels.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

public struct WSWeatherData {
    public let location: Location
    public let currentTemperature: WSCurrentTemperature
    public let forecasts: [TemperatureForecast]

    public struct Location {
        let name: String
        let country: String
    }

    public struct TemperatureForecast {

        public let dateTimestamp: Double
        public let dateString: String

        public let maximumTemperatureCelsius: Double
        public let maximumTemperatureFahrenheit: Double

        public let minimumTemperatureCelsius: Double
        public let minimumTemperatureFahrenheit: Double

        public let averageTemperatureCelsius: Double
        public let averageTemperatureFahrenheit: Double
    }
}

public struct WSCurrentTemperature {

    public let temperatureCelsius: Double
    public let temperatureFahrenheit: Double

    public let lastUpdateDateTimestamp: Double
    public let lastUpdateDateTimeString: String
}

public struct WSCurrentWeatherData {
    public let location: Location
    public let temperature: WSCurrentTemperature
}