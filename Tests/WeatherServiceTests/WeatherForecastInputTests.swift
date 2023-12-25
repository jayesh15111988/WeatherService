//
//  WeatherForecastInputTests.swift
//
//
//  Created by Jayesh Kawli on 12/25/23.
//

import XCTest
@testable import WeatherService

final class WeatherForecastInputTestsTests: XCTestCase {

    func testThatWeatherForecastInputReturnsValidQueryValueFromInput() {

        let locationNameInput = WeatherForecastInput.locationName(location: "Paris")

        XCTAssertEqual(locationNameInput.queryValue, "Paris")

        let coordinatesInput = WeatherForecastInput.coordinates(latitude: 23.5, longitude: 100.5)

        XCTAssertEqual(coordinatesInput.queryValue, "23.5,100.5")
    }
}
