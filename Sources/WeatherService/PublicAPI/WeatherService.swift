
import Foundation
import OSLog

/// A public interface to request and fetch weather information by location name or the coordinates
public final class WeatherService {

    static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: WeatherService.self)
    )

    private(set) var networkService: RequestHandling
    let localModelsCreator: LocalModelsCreator

    public init() {
        self.networkService = RequestHandler()
        self.localModelsCreator = LocalModelsCreator()
    }

    //For unit testing. Only to be called from unit test
    func replaceExistingNetworkService(with newNetworkService: RequestHandling) {
        self.networkService = newNetworkService
    }

    /// A method to download current and forecast weather details
    /// - Parameters:
    ///   - input: A kind of input passed for fetching the forecast details at location
    ///   - daysInFuture: Count of how many days in future you want to get forecast for
    ///   - completion: A completion block with downloaded WSWeatherData object and error if any
    public func forecast(with input: WeatherForecastInput, daysInFuture: Int, completion: @escaping (Result<WSWeatherData, DataLoadError>) -> Void) {

        self.networkService.request(type: WeatherData.self, route: .weatherForecast(input: input, forecastDays: daysInFuture)) { [weak self] result in

            guard let self else {
                Self.logger.error("self is prematurely deallocated from WeatherService class")
                completion(.failure(.genericError("Class is unexpectedly removed from the memory. Please try again")))
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
