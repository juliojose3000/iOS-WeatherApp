//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import SwiftUICore
import SwiftUI
import Combine
import CoreLocation


struct WeatherScreen: View {
    
    @StateObject var viewModel: WeatherViewModel
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.gray.opacity(0.5)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                if(viewModel.isLoading) {
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                        .padding()
                    
                } else if let weather = viewModel.weather {
                    
                    WeatherDataView(weatherData: weather)
                    
                } else if let error = viewModel.errorMessage {
                    
                } else {
                    
                }
                
            }
            
        }
        .onAppear {
            if let coord = locationManager.location {
                viewModel.loadWeather(lat: coord.latitude, lon: coord.longitude)
            }
        }
        .onChange(of: locationManager.location) { newLocation in
            if let coord = newLocation {
                viewModel.loadWeather(lat: coord.latitude, lon: coord.longitude)
            }
        }
    }
    
}

struct WeatherDataView: View {
    
    let weatherData: WeatherResponse
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            Header(weatherData: weatherData)
            BodyWeatherData(weatherData: weatherData)
            
        }
        .padding()
        
    }
    
}

struct Header: View {
    
    let weatherData: WeatherResponse
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Label(weatherData.name, systemImage: "location.fill")
                .font(.title2)
                .foregroundColor(.white)
            
            Text("\(Int(weatherData.main.temp))°")
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.white)
            
            HStack {
                
                Text("Max \(Int(weatherData.main.temp_max))°")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                Text("/ Min \(Int(weatherData.main.temp))°")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
            }
            
            Text("Feels like \(Int(weatherData.main.feels_like))°")
                .font(.system(size: 16))
                .foregroundColor(.white)

            Text("\(weatherData.weather.first?.main ?? "-")")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 1)

        }
        
    }
    
}

struct BodyWeatherData: View {
    
    let weatherData: WeatherResponse
    
    var body: some View {
        
        VStack(spacing: 12) {
            WeatherInfoCard(label: "Humidity: \(weatherData.main.humidity)%", systemImage: "drop.fill")
            WeatherInfoCard(label: String(format: "Wind: %.2f m/s", weatherData.wind.speed), systemImage: "wind")
            WeatherInfoCard(label: "Pressure: \(weatherData.main.pressure) hPa", systemImage: "gauge")
            WeatherInfoCard(label: "Sunset: \(weatherData.sys.sunset.toTimeString())", systemImage: "sunset.fill")
        }
        Spacer()
        
    }
    
}

struct WeatherInfoCard: View {
    
    let label: String
    let systemImage: String
    
    var body: some View {
        
        HStack {
            Text(label)
                .foregroundColor(.white)
                .font(.body)
            Spacer()
            Image(systemName: systemImage)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(16)
    }
    
}


#Preview {
    let mockRepo = MockWeatherRepository()
    let mockLocalRepo = MockLocalRepository()
    let viewModel = WeatherViewModel(repository: mockRepo, localRepository: mockLocalRepo)
    return WeatherScreen(viewModel: viewModel)
}

final class MockLocalRepository: WeatherLocalRepository {
    private var storedWeather: WeatherResponse?

    func save(weather: WeatherResponse) {
        storedWeather = weather
    }

    func fetchLatest() -> WeatherResponse? {
        return storedWeather
    }
}

final class MockWeatherRepository: WeatherRepository {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error> {
        let mock = WeatherResponse(
            coord: Coord(lon: -83.91, lat: 9.86),
            weather: [Weather(id: 1, main: "Clear", description: "Sunny", icon: "01d")],
            base: "stations",
            main: Main(temp: 77, feels_like: 78, temp_min: 76, temp_max: 80, pressure: 1012, humidity: 70, sea_level: nil, grnd_level: nil),
            visibility: 10000,
            wind: Wind(speed: 5, deg: 200, gust: nil),
            rain: nil,
            clouds: Clouds(all: 5),
            dt: 0,
            sys: Sys(type: 1, id: 1, country: "CR", sunrise: 0, sunset: 0),
            timezone: -21600,
            id: 123,
            name: "Cartago",
            cod: 200
        )
        return Just(mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

