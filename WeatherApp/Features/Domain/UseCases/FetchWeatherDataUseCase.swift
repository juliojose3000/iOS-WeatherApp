//
//  FetchWeatherDataUseCase.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import Combine

class FetchWeatherDataUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func run(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error> {
        return repository.fetchWeather(lat: lat, lon: lon)
    }
    

}
