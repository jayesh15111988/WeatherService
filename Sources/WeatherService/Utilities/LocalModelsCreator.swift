//
//  File.swift
//  
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

final class LocalModelsCreator {
    init() {

    }

    func getCurrentAndForecastWeatherData(from networkWeatherData: WeatherData) -> WSWeatherData {
        let location = networkWeatherData.location
        let currentTemperature = networkWeatherData.current
        let forecasts: [WSWeatherData.TemperatureForecast] = networkWeatherData.forecast.forecastday.map { forecastDay -> WSWeatherData.TemperatureForecast in

            let forecastData = forecastDay.forecastData

            return WSWeatherData.TemperatureForecast(
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


        return WSWeatherData(location: .init(name: location.name, country: location.country), currentTemperature: .init(temperatureCelsius: currentTemperature.temperatureCelsius, temperatureFahrenheit: currentTemperature.temperatureFahrenheit, lastUpdateDateTimestamp: currentTemperature.lastUpdatedDateTimestamp, lastUpdateDateTimeString: currentTemperature.lastUpdatedDateString), forecasts: forecasts)
    }

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
