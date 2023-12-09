import Foundation

public final class WeatherService {

    private let networkService: RequestHandling
    private let localModelsCreator: LocalModelsCreator

    public init() {
        self.networkService = RequestHandler()
        self.localModelsCreator = LocalModelsCreator()
    }

    public func forecastAndCurrentTemperature(for input: WeatherForecastInput, completion: @escaping (Result<WSWeatherData, DataLoadError>) -> Void) {
        self.networkService.request(type: WeatherData.self, route: .weatherForecast(input: input)) { [weak self] result in

            guard let self else {
                completion(.failure(.genericError("Class is unexpectedly removed from the memory. Please try again")))
                return
            }

            switch result {
            case .success(let weatherData):
                completion(.success(self.localModelsCreator.getCurrentAndForecastWeatherData(from: weatherData)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    public func currentTemperature(for input: WeatherForecastInput, completion: @escaping (Result<WSCurrentWeatherData, DataLoadError>) -> Void) {
        self.networkService.request(type: CurrentWeatherData.self, route: .weatherForecast(input: input)) { [weak self] result in

            guard let self else {
                completion(.failure(.genericError("Class is unexpectedly removed from the memory. Please try again")))
                return
            }

            switch result {
            case .success(let currentWeatherData):
                completion(.success(self.localModelsCreator.getCurrentWeatherData(from: currentWeatherData)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
