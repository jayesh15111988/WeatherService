# `Weather Service framework` for getting weather data

## Overview

`WeatherService` is an SDK modeled as a Swift package that allows users to fetch weather information from the weather API. 
In the current state,  API only downloads temperature data (Current and forecast) but can be extended to include other weather parameters such as rain, snowfall, and wind speed

## Users

The users of this framework will be able to use this SDK in their app by adding [git@github.com:jayesh15111988/WeatherService.git](https://github.com/jayesh15111988/WeatherService) URL as a dependency to their respective projects

## Current version

The latest version of SDK is 2.0.2

## Architecture

The SDK uses native `URLSession` API to download network data. To make API suitable for extension, I have added an extensible enum `APIRoute` that can be updated with new enum cases corresponding to extra URL endpoints with parameters. SDK uses `Codable` protocol to decode incoming JSON into local models which clients can process as per their needs.

I am using protocol-based approach to build the network service. The class for handling network requests conforms to a `RequestHandling` protocol. During testing, it is possible to create a mock class that conforms to this protocol and will allow injecting classes for mocking network requests and returning the mock data

## Source code

The source code of this framework is publicly available on GitHub at [git@github.com:jayesh15111988/WeatherService.git](https://github.com/jayesh15111988/WeatherService)

### Extensibility

Framework also supports future extensibility through the following additions

### 1. Use of `APIRoute` enum

  The use of this enum allows developers to add new endpoints in a seamless manner

### 2. Use of protocol-based approach for network requests

 I am using a protocol that the network service conforms to. Due to protocol usage, it's possible to replace the actual network service implementation by the mock class for testing purpose


## Testing


### Unit Tests

I have added comprehensive tests to the SDK to guarantee its stability and reliability. The unit tests are added with mocks and other protocol-based constructs. 

The current code coverage for the package is 93%. All the tests are situated under `Tests` folder in `WeatherService` project.


### UI/E2E tests

I haven't added any UI/E2E tests since they do not apply to the SDK.


## Framework Inclusion

To include `WeatherService` library in project, include `git@github.com:jayesh15111988/WeatherService.git` as a Swift package dependency


## Usage

### Importing

Add the following import line to the file where you wish to use this framework.

```swift
import WeatherService

```

### Using `WeatherService` framework

`WeatherService` public APIs take location details as input and return weather information at that place in the form of completion closure. The input is specified either in terms of coordinates or the name of the location

Weather forecast for 7 days with location coordinate inputs, we use shared instance of `WeatherService` object.


```swift
private let weatherService: WeatherServiceable = WeatherService.shared

weatherService.forecast(with: .coordinates(latitude: 56.3, longitude: 44.5), daysInFuture: 7) { result in

  switch result {

  case .success(let success):

    //TODO: Handle success

  case .failure(let failure):

    //TODO: Handle failure

  }
}

```

Weather forecast for 7 days with location name input



```swift

private let weatherService: WeatherServiceable = WeatherService.shared

weatherService.forecast(with: .locationName(location: "London"), daysInFuture: 7) { result in

  switch result {

  case .success(let success):

    //TODO: Handle success

  case .failure(let failure):

    //TODO: Handle failure

  }
}

```

## Key generation for API service

SDK currently uses the free API service provided by [WeatherAPI](https://www.weatherapi.com/api-explorer.aspx#forecast) to get the weather forecast data. 

To generate the API access key, please visit the [login page](https://www.weatherapi.com/login.aspx) to create a new account. 

Once logged in, visit the [My Account page](https://www.weatherapi.com/my/). Scroll to the bottom, accept the terms and conditions for generating an API key

and click the "Regenerate Key" button to generate a new API key.


## Third-party libraries

The SDK does not use any third-party library. 


## Deployment Targets

The minimum deployment target for the package is iOS 14


## Known limitations

1. SDK currently does not cache any data. The responsibility is offloaded to the client instead. This is done on purpose to keep the complexity to the minimum

2. SDK has support to only parse temperature information but can be extended to include other information such as rain forecast, snowfall, and wind speed

## Third party images

SDK does not use any third-party images

## Support
If you spot any bugs or are looking for the feature enhancement, please open a pull request on `https://github.com/jayesh15111988/WeatherService` repository
