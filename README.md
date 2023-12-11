# `Weather Service framework`

## Overview
`WeatherService` is an SDK modeled as a Swift package that allows users to fetch weather information from the weather API. In the current state, 
API only downloads temperature data but can be extended to include other weather parameters such as rain, snowfall and wind speed

## Users
The users of this framework will be able to use this SDK in their app by adding git@github.com:jayesh15111988/WeatherService.git URL as a dependency to their respective projects

## Current version
The latest version of SDK is 1.0

## Architecture
The SDK uses native `URLSession` API to download network data. In order to make API suitable for extension, I have added an extensible enum `APIRoute` that can be updated with new enum cases corresponding to 
extra URL endpoints. SDK uses `Codable` protocol to decode incoming JSON into local models which client can process as per their needs.

I am using protocol based approach to build the network service. The class for handling network requests conforms to a protocol. During testing, it is possible to create a mock class that conforms to this protocol and will
allow injecting classes for mocking network requests and returning mock data

## Source code
The source code of this framework is publicly available on GitHub at [git@github.com:jayesh15111988/WeatherService.git](https://github.com/jayesh15111988/WeatherService)

### Entry point


### Extensibility
Framework also supports future extensibility through the following additions
1. Use of `APIRoute` enum
   Use of this enum allows developers to add new endpoint easily

2. Use of protocol based approach for network requests
  I am using protocol that network service conforms to. Due to protocol usage, it's possible to replace the actual network service implementation by the mock class for testing purpose


## Framework Inclusion
To include `WeatherService` library in project, include `git@github.com:jayesh15111988/WeatherService.git` as a Swift package dependency

## Usage

### Importing
Add following import line to the file where you wish to use this framework.
```swift
import WeatherService
```

### Using `WeatherService` framrwork
`WeatherService` public APIs take location details as an input and return weather information at that place. The input is specified either in terms of coordinates or the name of the location

Weather forecast for 7 days with location coordinate inputs

```swift
WeatherService().forecast(with: .coordinates(latitude: 56.3, longitude: 44.5), daysInFuture: 7) { result in
    switch result {
    case .success(let success):
        //TODO:
    case .failure(let failure):
        //TODO:
    }
}
```

Weather forecast for 7 days with location name input

```swift
WeatherService().forecast(with: .locationName(location: "London"), daysInFuture: 7) { result in
    switch result {
    case .success(let success):
        //TODO:
    case .failure(let failure):
        //TODO:
    }
}
```

## Third-party libraries
The SDK does not use any third-party library. 

## Deployment Targets
The minimum deployment target for the package is iOS 14

## Known limitations
1. SDK currently does not cache any data. The responsibility is offloaded to the client instead. This is done on purpose to keep the complexity to the minimum
2. SDK has support to only parse temperature information but can be extended to include other information such as rain forecast, snowfall and wind speed

## Third party images
SDK does not use any third-party images

