//
//  RequestHandlerTests.swift
//
//
//  Created by Jayesh Kawli on 12/11/23.
//

@testable import WeatherService
import XCTest

final class RequestHandlerTests: XCTestCase {

    var mockSession: URLSession!
    let validResponse = HTTPURLResponse(url: URL(string: "https://something.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let invalidResponse = HTTPURLResponse(url: URL(string: "https://something.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
    var networkService: RequestHandler!

    override func setUp() {
        super.setUp()
        setupURLProtocolMock()
        networkService = RequestHandler(urlSession: mockSession)
    }

    override func tearDown() {
        super.tearDown()
        URLProtocolMock.mockURLs = [:]
    }

    func testThatNetworkServiceCorrectlyHandlesValidResponse() {
        let urlWithValidData = "https://api.weatherapi.com/v1/forecast.json?key=1b4da9ef35af4cd7b10151607230912&q=London_valid_response&days=7"

        let jsonString = """
    {"name": "London", "country": "UK"}
"""
        let validData = jsonString.data(using: .utf8)

        URLProtocolMock.mockURLs = [
            URL(string: urlWithValidData): (nil, validData, validResponse)
        ]

        let expectation = XCTestExpectation(description: "Successful JSON to model conversion while loading valid data from API")

        networkService.request(type: Location.self, route: .weatherForecast(input: .locationName(location: "London_valid_response"), forecastDays: 7)) { result in
            if case .success = result {
                // No-op. If we reached here, that means we passed the test
            } else {
                XCTFail("Test failed. Expected to get the valid data without any error. Failed due to unexpected result")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testThatNetworkServiceCorrectlyHandlesResponseWithError() {
        let urlWithError = "https://api.weatherapi.com/v1/forecast.json?key=1b4da9ef35af4cd7b10151607230912&q=London_random_error&days=7"

        URLProtocolMock.mockURLs = [
            URL(string: urlWithError): (DataLoadError.genericError("Something went wrong"), nil, validResponse)
        ]

        let expectation = XCTestExpectation(description: "Unsuccessful data load operation due to generic error data")

        networkService.request(type: Location.self, route: .weatherForecast(input: .locationName(location: "London_random_error"), forecastDays: 7)) { result in
            if case .failure(let error) = result {
                if case let .genericError(message) = error {
                    XCTAssertEqual(message, "The operation couldn’t be completed. (WeatherService.DataLoadError error 0.)", "Received unexpected kind of error message. Expected 'Something went wrong'")
                } else {
                    XCTFail("Received unexpected kind of error. Expected Generic error message")
                }
            } else {
                XCTFail("Test failed. Expected to get the DataLoadError with type genericError with error message. Failed due to unexpected result")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testThatNetworkServiceCorrectlyHandlesResponseWithInvalidResponseCode() {
        let urlWithInvalidResponse = "https://api.weatherapi.com/v1/forecast.json?key=1b4da9ef35af4cd7b10151607230912&q=London_invalid&days=7"

        let invalidResponse = HTTPURLResponse(url: URL(string: "https://github.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)

        let jsonString = """
    {"name": "London"}
"""
        let invalidData = jsonString.data(using: .utf8)

        URLProtocolMock.mockURLs = [
            URL(string: urlWithInvalidResponse): (nil, invalidData, invalidResponse)
        ]

        let expectation = XCTestExpectation(description: "Unsuccessful data load operation due to invalid response code")

        networkService.request(type: Location.self, route: .weatherForecast(input: .locationName(location: "London_invalid"), forecastDays: 7)) { result in
            if case .failure(.invalidResponseCode(let code)) = result {
                XCTAssertEqual(code, 400)
            } else {
                XCTFail("Test failed. Expected to get the DataLoadError with type invalidResponseCode with error message. Failed due to unexpected result")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testThatNetworkServiceCorrectlySendsAnErrorForUnreachableConnection() {
        let urlWithNetworkError = "https://api.weatherapi.com/v1/forecast.json?key=1b4da9ef35af4cd7b10151607230912&q=London_network&days=7"

        URLProtocolMock.mockURLs = [
            URL(string: urlWithNetworkError): (NSError(domain: "unit_test", code: -1009), nil, validResponse)
        ]

        let expectation = XCTestExpectation(description: "Unsuccessful data load operation due to unreachable network connection")

        networkService.request(type: Location.self, route: .weatherForecast(input: .locationName(location: "London_network"), forecastDays: 7)) { result in
            if case let .failure(dataLoadError) = result {
                guard case .internetUnavailable = dataLoadError else {
                    XCTFail("Mismatch between actual data load error and received error type. Expected internetAvailable type")
                    return
                }
            } else {
                XCTFail("Test failed. Expected to get the DataLoadError with type genericError with error message. Failed due to unexpected result")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testThatNetworkServiceCorrectlySendsAnErrorForMalformedContent() {
        let urlWithInvalidResponse = "https://api.weatherapi.com/v1/forecast.json?key=1b4da9ef35af4cd7b10151607230912&q=12,34_invalid&days=7"

        let jsonString = """
    {"name": "London"}
"""
        let invalidData = jsonString.data(using: .utf8)

        URLProtocolMock.mockURLs = [
            URL(string: urlWithInvalidResponse): (nil, invalidData, validResponse)
        ]

        let expectation = XCTestExpectation(description: "Unsuccessful data load operation due to invalid response code")

        networkService.request(type: Location.self, route: .weatherForecast(input: .coordinates(latitude: 12, longitude: 34), forecastDays: 7)) { result in
            if case .failure(.malformedContent) = result {
                //no-op. If we came here, that means we already passed the test
            } else {
                XCTFail("Test failed. Expected to get the DataLoadError with type invalidResponseCode with error message. Failed due to unexpected result")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    // MARK: Private methods
    private func setupURLProtocolMock() {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        mockSession = URLSession(configuration: sessionConfiguration)
    }
}
