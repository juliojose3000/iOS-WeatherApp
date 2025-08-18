//
//  WeatherLocalRepository.swift
//  WeatherApp
//
//  Created by Julio on 18/8/25.
//

protocol WeatherLocalRepository {
    func save(weather: WeatherResponse)
    func fetchLatest() -> WeatherResponse?
}
