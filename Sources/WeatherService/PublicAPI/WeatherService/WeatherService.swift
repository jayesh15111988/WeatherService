//
//  WeatherService.swift
//
//
//  Created by Jayesh Kawli on 12/25/23.
//

import Foundation

public protocol WeatherServiceable: AnyObject {
    func forecast(
        with input: WeatherForecastInput,
        daysInFuture: Int,
        completion: @escaping (Result<WSWeatherData, DataLoadError>
        ) -> Void)
}

public final class WeatherService {

    public static let shared: WeatherServiceable = WeatherDataFetcher()

    init() {
        //no-op
    }
}
