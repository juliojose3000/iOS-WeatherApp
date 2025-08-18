//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import Foundation
import Combine
import Network

//When a class conforms to ObservableObject, it allows SwiftUI views to observe changes in that class and automatically update the UI when changes happen.
final class WeatherViewModel: ObservableObject {
    // MARK: - Published UI State
    
    //@Published is a property wrapper from Combine.
    //You use it to mark properties inside an ObservableObject that should trigger UI updates when changed.
    @Published var weather: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var offline: Bool = false

    // MARK: - Dependencies
    private let repository: WeatherRepository
    private let localRepository: WeatherLocalRepository
    private var cancellables = Set<AnyCancellable>()
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")

    // MARK: - Init
    init(repository: WeatherRepository, localRepository: WeatherLocalRepository) {
        self.repository = repository
        self.localRepository = localRepository
        startNetworkMonitoring()
    }
    
    // MARK: - Network Monitoring
    private func startNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.offline = (path.status != .satisfied)
            }
        }
        monitor.start(queue: monitorQueue)
    }

    // MARK: - Public Methods
    
    func loadWeather(lat: Double, lon: Double) {
        
        if offline {
            let cached = localRepository.fetchLatest()
            self.weather = cached
            print("Device is offline, loading cache data")
        } else {
            loadWeatherRemotely(lat: lat, lon: lon)
        }
        
    }
    
    func loadWeatherRemotely(lat: Double, lon: Double) {
        isLoading = true
        errorMessage = nil
        weather = nil

        repository.fetchWeather(lat: lat, lon: lon)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false

                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.weather = response
                self?.localRepository.save(weather: response)
            }
            .store(in: &cancellables)
    }
}
