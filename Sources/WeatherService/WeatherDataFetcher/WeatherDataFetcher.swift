
import Foundation
import OSLog

/// An interface to request and fetch weather information by location name or the coordinates
final class WeatherDataFetcher: WeatherServiceable {

    static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: WeatherDataFetcher.self)
    )

    private let networkService: RequestHandling
    private let localModelsCreator: LocalModelsCreator

    init(networkService: RequestHandling = RequestHandler()) {
        self.networkService = networkService
        self.localModelsCreator = LocalModelsCreator()
    }

    /// A method to download current and forecast weather details
    /// - Parameters:
    ///   - input: A kind of input passed for fetching the forecast details at location
    ///   - daysInFuture: Count of how many days in future you want to get forecast for
    ///   - completion: A completion block with downloaded WSWeatherData object and error if any
    func forecast(
        with input: WeatherForecastInput,
        daysInFuture: Int,
        completion: @escaping (Result<WSWeatherData, DataLoadError>
        ) -> Void) {

        self.networkService.request(type: WeatherData.self, route: .weatherForecast(input: input, forecastDays: daysInFuture)) { [weak self] result in

            guard let self else {
                Self.logger.error("self is prematurely deallocated from WeatherService class")
                completion(.failure(.genericError("Current instance has been unexpectedly removed from the memory. Please try again")))
                return
            }

            switch result {
            case .success(let weatherData):

                completion(.success(self.localModelsCreator.getCurrentAndForecastWeatherData(from: weatherData)))

            case .failure(let failure):

                Self.logger.info("Failed to fetch data for weather forecast. Failed with \(failure.errorMessageString())")
                completion(.failure(failure))

            }
        }
    }
}
