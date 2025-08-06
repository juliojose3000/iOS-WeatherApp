//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Julio on 6/8/25.
//

import Foundation
import Combine

//When a class conforms to ObservableObject, it allows SwiftUI views to observe changes in that class and automatically update the UI when changes happen.
final class WeatherViewModel: ObservableObject {
    // MARK: - Published UI State
    
    //@Published is a property wrapper from Combine.
    //You use it to mark properties inside an ObservableObject that should trigger UI updates when changed.
    @Published var weather: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies
    private let repository: WeatherRepository
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(repository: WeatherRepository) {
        self.repository = repository
    }

    // MARK: - Public Methods
    func loadWeather(lat: Double, lon: Double) {
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
            }
            .store(in: &cancellables)
    }
}
