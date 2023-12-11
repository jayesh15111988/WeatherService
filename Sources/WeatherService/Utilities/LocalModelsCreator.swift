//
//  LocalModelsCreator.swift
//  
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

/// An utility to create local weather data models
final class LocalModelsCreator {

    init() {

    }
    
    /// A method to get current and forecast weather data from passed data received from the network
    /// - Parameter networkWeatherData: A weather data received from the network
    /// - Returns: An object of type WSWeatherData
    func getCurrentAndForecastWeatherData(from networkWeatherData: WeatherData) -> WSWeatherData {
        let location = networkWeatherData.location
        let currentTemperature = networkWeatherData.current
        let forecasts: [WSWeatherData.Forecast] = networkWeatherData.forecast.forecastday.map { forecastDay -> WSWeatherData.Forecast in

            let forecastData = forecastDay.forecastData

            return WSWeatherData.Forecast(
                dateTimestamp: forecastDay.dateTimestamp,
                dateString: forecastDay.dateString,
                maximumTemperatureCelsius: forecastData.maxTempCelsius,
                maximumTemperatureFahrenheit: forecastData.maxTempFahrenheit,
                minimumTemperatureCelsius: forecastData.minTempCelsius,
                minimumTemperatureFahrenheit: forecastData.minTempFahrenheit,
                averageTemperatureCelsius: forecastData.averageTempCelsius,
                averageTemperatureFahrenheit: forecastData.averageTempFahrenheit
            )
        }

        return WSWeatherData(
            location: .init(
                name: location.name,
                country: location.country),
            current: .init(
                temperatureCelsius: currentTemperature.temperatureCelsius,
                temperatureFahrenheit: currentTemperature.temperatureFahrenheit,
                lastUpdateDateTimestamp: currentTemperature.lastUpdatedDateTimestamp,
                lastUpdateDateTimeString: currentTemperature.lastUpdatedDateString),
            forecasts: forecasts
        )
    }
    
    /// A method to get current weather data from passed network object
    /// - Parameter currentNetworkWeatherData: An object of type CurrentWeatherData representing network weather data
    /// - Returns: An object of type WSCurrentWeatherData
    func getCurrentWeatherData(from currentNetworkWeatherData: CurrentWeatherData) -> WSCurrentWeatherData {

        let location = currentNetworkWeatherData.location
        let temperature = currentNetworkWeatherData.current

        return WSCurrentWeatherData(
            location: .init(name: location.name, country: location.country),
            temperature: .init(
                temperatureCelsius: temperature.temperatureCelsius,
                temperatureFahrenheit: temperature.temperatureFahrenheit,
                lastUpdateDateTimestamp: temperature.lastUpdatedDateTimestamp,
                lastUpdateDateTimeString: temperature.lastUpdatedDateString)
        )
    }
}
