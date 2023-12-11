//
//  RequestHandlerMock.swift
//
//
//  Created by Jayesh Kawli on 12/11/23.
//

import Foundation
@testable import WeatherService

final class RequestHandlerMock: RequestHandling {
    
    var toFail = false

    private let weatherData = WeatherData(location: .init(name: "London", country: "UK"), current: .init(lastUpdatedDateString: "2008-12-11 12:22", lastUpdatedDateTimestamp: 3933938, temperatureCelsius: 32, temperatureFahrenheit: 120), forecast: .init(forecastday: [.init(dateString: "12-11-2009", dateTimestamp: 123123, forecastData: .init(maxTempCelsius: 12.4, maxTempFahrenheit: 23.4, minTempCelsius: 1.24, minTempFahrenheit: 2.34, averageTempCelsius: 3.5, averageTempFahrenheit: 5.6))]))
    
    init() {

    }

    func request<T: Decodable>(type: T.Type, route: APIRoute, completion: @escaping (Result<T, DataLoadError>) -> Void) {
        if toFail {
            completion(.failure(.badURL))
        } else {
            completion(.success(weatherData as! T))
        }
    }
}
