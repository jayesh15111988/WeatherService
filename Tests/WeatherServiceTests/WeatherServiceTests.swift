//
//  WeatherServiceTests.swift
//  
//
//  Created by Jayesh Kawli on 12/11/23.
//

import XCTest
@testable import WeatherService

final class WeatherServiceTests: XCTestCase {

    private var weatherService: WeatherService!

    override func setUp() {
        super.setUp()
    }

    func testThatWeatherServiceCorrectlyHandlesTheSuccessResponse() {
        self.weatherService = WeatherService()
        self.weatherService.replaceExistingNetworkService(with: RequestHandlerMock())

        weatherService.forecast(with: .locationName(location: "London"), daysInFuture: 7) { result in
            switch result {
            case .success(let convertedWeatherData):

                XCTAssertEqual(convertedWeatherData.location.name, "London", "Location names do not match for converted weather data")
                XCTAssertEqual(convertedWeatherData.location.country, "UK", "country names do not match for converted weather data")
                XCTAssertEqual(convertedWeatherData.current.lastUpdateDateTimeString, "2008-12-11 12:22", "lastUpdateDateTimeString do not match for converted weather data")
                XCTAssertEqual(convertedWeatherData.current.lastUpdateDateTimestamp, 3933938, "lastUpdateDateTimestamp do not match for converted weather data")
                XCTAssertEqual(convertedWeatherData.current.temperatureCelsius, 32, "Celsius temperature do not match for converted weather data")
                XCTAssertEqual(convertedWeatherData.current.temperatureFahrenheit, 120, "Fahrenheit temperatures do not match for converted weather data")

            case .failure:
                XCTFail("Expected to get the success response and execute the success block. Unexpected entry into failure case")
            }
        }
    }

    func testThatWeatherServiceCorrectlyHandlesTheErrorResponse() {
        let requestHandler = RequestHandlerMock()
        requestHandler.toFail = true

        self.weatherService = WeatherService()
        self.weatherService.replaceExistingNetworkService(with: requestHandler)

        self.weatherService.forecast(with: .locationName(location: "London"), daysInFuture: 7) { result in
            switch result {
            case .success:
                XCTFail("Expected to get the failure response and execute the success block. Unexpected entry into success case")
            case .failure(let failure):
                if case .badURL = failure {
                    //no-op. If we reached here, we successfully passed the test
                    return
                } else {
                    XCTFail("Received unexpected failure from weather service. Expected badURL kind of DataLoadError")
                }
            }
        }
    }
}
