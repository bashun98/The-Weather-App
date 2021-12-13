//
//  CitiesInteractor.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//
//

import Foundation

final class CitiesInteractor {
    private let weatherManager: WeatherManagerDiscription
    weak var output: CitiesInteractorOutput?
    
    init(weatherManager: WeatherManagerDiscription = WeatherManager.shared) {
        self.weatherManager = weatherManager
    }
}

extension CitiesInteractor: CitiesInteractorInput {
    func loadCities() {
        weatherManager.loadCities(with: ["524901", "292223"]) { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didLoad(cities: response.list)
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        }
    }
    
    func loadCity(with name: String) {
        weatherManager.loadCity(with: name) { [weak output] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    output?.didLoad(city: response)
                case .failure(let error):
                    output?.didFail(with: error)
                }
            }
        }
    }
    
}
