//
//  APIRoute.swift
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation
import CoreLocation

/// An enum representing different inputs to API for weather details
public enum WeatherForecastInput {

    case locationName(location: String)
    case coordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees)

    // Converting enum to URL queries
    var queryValue: String {
        switch self {
        case .locationName(let location):
            return location
        case .coordinates(let latitude, let longitude):
            return "\(latitude),\(longitude)"
        }
    }
}

/// An enum to encode all the operations associated with specific endpoint
enum APIRoute {

    case weatherForecast(input: WeatherForecastInput, forecastDays: Int)

    //Base URL for the weather API
    private var baseURLString: String { "https://api.weatherapi.com/v1/" }

    //An API key required to make a call and get the JSON response back
    private static let apiKey = "1b4da9ef35af4cd7b10151607230912"

    private var url: URL? {
        switch self {
        case .weatherForecast:
            return URL(string: baseURLString + "forecast.json")
        }
    }
    
    /// A parameters to include in then network request
    private var parameters: [URLQueryItem] {

        var queryItems: [URLQueryItem] = [URLQueryItem(name: "key", value: Self.apiKey)]

        switch self {
        case .weatherForecast(let inputType, let forecastDays):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "q", value: inputType.queryValue),
                URLQueryItem(name: "days", value: "\(forecastDays)")
            ])
        }
        return queryItems
    }

    /// A method to convert given APIRoute case into URLRequest object
    /// - Returns: An instance of URLRequest
    func asRequest() -> URLRequest {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if !parameters.isEmpty {
            components?.queryItems = parameters
        }

        guard let parametrizedURL = components?.url else {
            preconditionFailure("Missing URL with parameters for url: \(url)")
        }

        return URLRequest(url: parametrizedURL)
    }
}
