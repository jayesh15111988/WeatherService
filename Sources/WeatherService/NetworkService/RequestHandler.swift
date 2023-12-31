//
//  RequestHandler.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

/// An enum to represent various kinds of errors occurred while getting data from the network
public enum DataLoadError: Error {
    case badURL
    case genericError(String)
    case noData
    case malformedContent
    case invalidResponseCode(Int)
    case decodingError(String)
    case internetUnavailable

    public func errorMessageString() -> String {
        switch self {
        case .badURL:
            return "Invalid URL encountered. Please enter the valid URL and try again"
        case let .genericError(message):
            return message
        case .noData:
            return "No data received from the server. Please try again later"
        case .malformedContent:
            return "Received malformed content. Error may have been logged on the server to investigate further"
        case let .invalidResponseCode(code):
            return "Server returned invalid response code. Expected 200. Server returned \(code)"
        case let .decodingError(message):
            return message
        case .internetUnavailable:
            return "Your internet connection seems to be offline. Please check the connection and try again"
        }
    }
}

final class RequestHandler: RequestHandling {

    private let urlSession: URLSession
    private let decoder: JSONDecoder

    public init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    /// A method to request network data with route and completion handler
    /// - Parameters:
    ///   - type: Type of Decodable object we want to fetch
    ///   - route: A route for the request
    ///   - completion: Completion closure containing decodable type and error if any
    func request<T: Decodable>(type: T.Type, route: APIRoute, completion: @escaping (Result<T, DataLoadError>) -> Void) {

        let task = urlSession.dataTask(with: route.asRequest()) { (data, response, error) in

            // We check if the request failed due to network unavailability
            // We will check three conditions - cannot find host, cannot connect to host and not connected to internet
            if let nsError = (error as? NSError), [.notConnectedToInternet, .cannotConnectToHost, .cannotFindHost ].contains(URLError.Code(rawValue: nsError.code)) {
                completion(.failure(.internetUnavailable))
                return
            }

            if let error = error {
                completion(.failure(.genericError(error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            if let responseCode = (response as? HTTPURLResponse)?.statusCode, responseCode != 200 {
                completion(.failure(.invalidResponseCode(responseCode)))
                return
            }

            do {
                let responsePayload = try self.decoder.decode(type.self, from: data)
                completion(.success(responsePayload))
            } catch {
                completion(.failure(.malformedContent))
            }
        }
        task.resume()
    }
}
