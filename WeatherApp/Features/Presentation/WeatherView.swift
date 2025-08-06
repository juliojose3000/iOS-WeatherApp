//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import SwiftUICore
import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let weather = viewModel.weather {
                Text("City: \(weather.name)")
                Text("Temp: \(weather.main.temp)°")
                Text("Condition: \(weather.weather.first?.description ?? "-")")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("No data yet")
            }
        }
        .onAppear {
            viewModel.loadWeather(lat: 37.4220936, lon: -122.083922)
        }
    }
}
