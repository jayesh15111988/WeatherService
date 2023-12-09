//
//  CurrentWeatherData.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

struct CurrentWeatherData: Decodable {
    let current: CurrentWeather
    let location: Location
}
