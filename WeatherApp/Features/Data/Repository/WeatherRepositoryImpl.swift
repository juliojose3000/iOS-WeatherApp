//
//  WeatherRepositoryImpl.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import Combine

class WeatherRepositoryImpl: WeatherRepository {
    
    private let apiClient: ApiClient
    private let weatherApiKey = "93dc26e962f6e56f70e239e538b36285"
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    //AnyPublisher allows you to chain more Combine operators (map, retry, debounce, catch, etc.) before returning the value.
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error> {
        let endpoint = WeatherAPI.fetchWeather(lat: lat, lon: lon, weatherApiKey: weatherApiKey)
        return apiClient.request(endpoint)
    }
    
}

