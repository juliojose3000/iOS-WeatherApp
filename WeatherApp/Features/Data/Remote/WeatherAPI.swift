//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import Foundation

enum WeatherAPI: Endpoint {
    
    case fetchWeather(lat: Double, lon: Double, weatherApiKey: String)

    var path: String {
        switch self {
        case .fetchWeather: return "/weather"
        }
    }

    var method: String {
        return "GET"
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchWeather(let lat, let lon, let weatherApiKey):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: "\(weatherApiKey)"),
                URLQueryItem(name: "units", value: "imperial")
            ]
        }
    }
}
