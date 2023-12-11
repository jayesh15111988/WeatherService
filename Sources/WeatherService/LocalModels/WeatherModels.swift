//
//  WeatherModels.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

/// A structure to encode weather data in final format and sending it over to client
public struct WSWeatherData {
    public let location: Location
    public let current: WSCurrent
    public let forecasts: [Forecast]

    public struct Location {
        let name: String
        let country: String
    }

    public struct Forecast {

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

public struct WSCurrent {

    public let temperatureCelsius: Double
    public let temperatureFahrenheit: Double

    public let lastUpdateDateTimestamp: Double
    public let lastUpdateDateTimeString: String
}

public struct WSCurrentWeatherData {
    public let location: Location
    public let temperature: WSCurrent
}
