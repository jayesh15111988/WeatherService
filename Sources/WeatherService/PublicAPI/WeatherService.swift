
import Foundation
import OSLog

/// A public interface to request and fetch weather information by location name or the coordinates
public final class WeatherService {

    static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: WeatherService.self)
    )

    private let networkService: RequestHandling
    private let localModelsCreator: LocalModelsCreator

    public init() {
        self.networkService = RequestHandler()
        self.localModelsCreator = LocalModelsCreator()
    }

    /// A method to download current and forecast weather details
    /// - Parameters:
    ///   - input: A kind of input passed for fetching temperature details at location
    ///   - completion: A completion block with downloaded WSWeatherData object and error if any
    public func forecastAndCurrentTemperature(for input: WeatherForecastInput, completion: @escaping (Result<WSWeatherData, DataLoadError>) -> Void) {

        self.networkService.request(type: WeatherData.self, route: .weatherForecast(input: input)) { [weak self] result in

            guard let self else {
                Self.logger.error("self is prematurely deallocated from WeatherService class")
                completion(.failure(.genericError("Class is unexpectedly removed from the memory. Please try again")))
                return
            }

            switch result {
            case .success(let weatherData):
                completion(.success(self.localModelsCreator.getCurrentAndForecastWeatherData(from: weatherData)))
            case .failure(let failure):
                Self.logger.info("Failed to fetch data for temperature forecast. Failed with \(failure.errorMessageString())")
                completion(.failure(failure))
            }
        }
    }
    
    /// A method to fetch current temperature from the given weather input
    /// - Parameters:
    ///   - input: Weather input value to get info
    ///   - completion: A completion block with downloaded WSCurrentWeatherData object and error if any
    public func currentTemperature(for input: WeatherForecastInput, completion: @escaping (Result<WSCurrentWeatherData, DataLoadError>) -> Void) {
        self.networkService.request(type: CurrentWeatherData.self, route: .weatherForecast(input: input)) { [weak self] result in

            guard let self else {
                Self.logger.error("self is prematurely deallocated from WeatherService class")
                completion(.failure(.genericError("Class is unexpectedly removed from the memory. Please try again")))
                return
            }

            switch result {
            case .success(let currentWeatherData):
                completion(.success(self.localModelsCreator.getCurrentWeatherData(from: currentWeatherData)))
            case .failure(let failure):
                Self.logger.info("Failed to fetch data for current temperature. Failed with \(failure.errorMessageString())")
                completion(.failure(failure))
            }
        }
    }
}
