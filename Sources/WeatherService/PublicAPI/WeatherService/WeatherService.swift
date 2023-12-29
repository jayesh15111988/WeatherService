//
//  WeatherService.swift
//
//
//  Created by Jayesh Kawli on 12/25/23.
//

import Foundation

/// A protocol that network service conforms to and can be used during unit testing
public protocol WeatherServiceable: AnyObject {
    func forecast(
        with input: WeatherForecastInput,
        daysInFuture: Int,
        completion: @escaping (Result<WSWeatherData, DataLoadError>
        ) -> Void)
}

/// A shared instance of WeatherService used to fetch network data
public final class WeatherService {

    public static let shared: WeatherServiceable = WeatherDataFetcher()

    init() {
        //no-op
    }
}
