//
//  LocalModelsCreatorTests.swift
//  
//
//  Created by Jayesh Kawli on 12/11/23.
//

import XCTest
@testable import WeatherService

final class LocalModelsCreatorTests: XCTestCase {

    private let localModelsCreator = LocalModelsCreator()

    private let weatherData = WeatherData(location: .init(name: "London", country: "UK"), current: .init(lastUpdatedDateString: "2008-12-11 12:22", lastUpdatedDateTimestamp: 3933938, temperatureCelsius: 32, temperatureFahrenheit: 120), forecast: .init(forecastday: [.init(dateString: "12-11-2009", dateTimestamp: 123123, forecastData: .init(maxTempCelsius: 12.4, maxTempFahrenheit: 23.4, minTempCelsius: 1.24, minTempFahrenheit: 2.34, averageTempCelsius: 3.5, averageTempFahrenheit: 5.6))]))

    private let currentWeatherData = CurrentWeatherData(current: .init(lastUpdatedDateString: "12-10-2008", lastUpdatedDateTimestamp: 123123, temperatureCelsius: 32, temperatureFahrenheit: 22), location: .init(name: "Boston", country: "USA"))

    override func setUp() {
        super.setUp()
    }

    func testThatLocalModelsCreatorConvertsNetworkWeatherDataToLocalWeatherDataModel() {

        let convertedWeatherData = localModelsCreator.getCurrentAndForecastWeatherData(from: weatherData)

        XCTAssertEqual(convertedWeatherData.location.name, "London", "Location names do not match for converted weather data")
        XCTAssertEqual(convertedWeatherData.location.country, "UK", "country names do not match for converted weather data")
        XCTAssertEqual(convertedWeatherData.current.lastUpdateDateTimeString, "2008-12-11 12:22", "lastUpdateDateTimeString do not match for converted weather data")
        XCTAssertEqual(convertedWeatherData.current.lastUpdateDateTimestamp, 3933938, "lastUpdateDateTimestamp do not match for converted weather data")
        XCTAssertEqual(convertedWeatherData.current.temperatureCelsius, 32, "Celsius temperature do not match for converted weather data")
        XCTAssertEqual(convertedWeatherData.current.temperatureFahrenheit, 120, "Fahrenheit temperatures do not match for converted weather data")

        let forecast = convertedWeatherData.forecasts.first!

        XCTAssertEqual(forecast.averageTemperatureCelsius, 3.5, "Average temperature celsius do not match for converted weather data")
        XCTAssertEqual(forecast.averageTemperatureFahrenheit, 5.6, "Average temperature Fahrenheit do not match for converted weather data")
        XCTAssertEqual(forecast.dateString, "12-11-2009", "date string do not match for converted weather data")
        XCTAssertEqual(forecast.dateTimestamp, 123123, "date timestamp do not match for converted weather data")
        XCTAssertEqual(forecast.maximumTemperatureCelsius, 12.4, "maximum temperature celsius do not match for converted weather data")
        XCTAssertEqual(forecast.maximumTemperatureFahrenheit, 23.4, "maximum temperature Fahrenheit do not match for converted weather data")
        XCTAssertEqual(forecast.minimumTemperatureCelsius, 1.24, "minimum temperature celsius do not match for converted weather data")
        XCTAssertEqual(forecast.minimumTemperatureFahrenheit, 2.34, "minimum temperature Fahrenheit do not match for converted weather data")
    }

    func testThatLocalModelsCreatorConvertsNetworkWeatherDataToCurrentWeatherData() {
        let convertedCurrentWeatherData = localModelsCreator.getCurrentWeatherData(from: currentWeatherData)

        XCTAssertEqual(convertedCurrentWeatherData.location.name, "Boston", "location names do not match for current weather data")
        XCTAssertEqual(convertedCurrentWeatherData.location.country, "USA", "countries do not match for current weather data")
        XCTAssertEqual(convertedCurrentWeatherData.temperature.lastUpdateDateTimeString, "12-10-2008", "last updated date time strings do not match for current weather data")
        XCTAssertEqual(convertedCurrentWeatherData.temperature.lastUpdateDateTimestamp, 123123, "last updated date timestamps do not match for current weather data")
        XCTAssertEqual(convertedCurrentWeatherData.temperature.temperatureCelsius, 32, "temperatures in celsius do not match for current weather data")
        XCTAssertEqual(convertedCurrentWeatherData.temperature.temperatureFahrenheit, 22, "temperatures in Fahrenheit do not match for current weather data")
    }
}

