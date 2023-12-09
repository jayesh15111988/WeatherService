//
//  Forecast.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

struct Forecast: Decodable {
    let forecastday: [Forecastday]
}

struct Forecastday: Decodable {
    let dateString: String
    let dateTimestamp: Double
    let forecastData: DayForecastData

    enum CodingKeys: String, CodingKey {
        case dateString = "date"
        case dateTimestamp = "date_epoch"
        case forecastData = "day"
    }
}

struct DayForecastData: Decodable {
    let maxTempCelsius: Double
    let maxTempFahrenheit: Double
    let minTempCelsius: Double
    let minTempFahrenheit: Double
    let averageTempCelsius: Double
    let averageTempFahrenheit: Double

    enum CodingKeys: String, CodingKey {
        case maxTempCelsius = "maxtemp_c"
        case maxTempFahrenheit = "maxtemp_f"
        case minTempCelsius = "mintemp_c"
        case minTempFahrenheit = "mintemp_f"
        case averageTempCelsius = "avgtemp_c"
        case averageTempFahrenheit = "avgtemp_f"
    }
}
