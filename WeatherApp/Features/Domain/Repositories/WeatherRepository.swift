//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//
import Combine //It allows us to use Future

protocol WeatherRepository {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error>
}
