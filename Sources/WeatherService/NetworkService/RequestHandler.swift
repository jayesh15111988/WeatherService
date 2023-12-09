//
//  RequestHandler.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

public enum DataLoadError: Error {
    case badURL
    case genericError(String)
    case noData
    case malformedContent
    case invalidResponseCode(Int)
    case decodingError(String)

    func errorMessageString() -> String {
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
        }
    }
}

final class RequestHandler: RequestHandling {

    private let urlSession: URLSession
    private let decoder: JSONDecoder

    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    func request<T: Decodable>(type: T.Type, route: APIRoute, completion: @escaping (Result<T, DataLoadError>) -> Void) {

        let task = urlSession.dataTask(with: route.asRequest()) { (data, response, error) in

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
                let decoder = JSONDecoder()
                let responsePayload = try decoder.decode(type.self, from: data)
                completion(.success(responsePayload))
            } catch {
                completion(.failure(.malformedContent))
            }
        }
        task.resume()
    }
}
