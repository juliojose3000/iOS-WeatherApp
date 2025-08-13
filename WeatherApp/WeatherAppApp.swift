//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = ApiClient(baseURL: URL(string: "https://api.openweathermap.org/data/2.5")!)
            let weatherRepo = WeatherRepositoryImpl(apiClient: apiClient)
            WeatherScreen(viewModel: WeatherViewModel(repository: weatherRepo))
        }
    }
}

//https://api.openweathermap.org/data/2.5/weather?lat=37.4220936&lon=-122.083922&appid=93dc26e962f6e56f70e239e538b36285&units=imperial
