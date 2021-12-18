//
//  WeatherManager.swift
//  The Weather App
//
//  Created by Евгений Башун on 26.11.2021.
//

import Foundation

protocol WeatherManagerDiscription: AnyObject {
    func loadCities(with ids: [String], completion: @escaping (Result<CitiesResponse, Error>) -> Void)
    func loadCity(with name: String, completion: @escaping (Result<CityResponse, Error>) -> Void)
}

enum NetworkError: Error {
    case unexpected
}

final class WeatherManager: WeatherManagerDiscription {
    static let shared: WeatherManagerDiscription = WeatherManager()
    static let appId = "22524f29e63ff1d044e0dbbf24b4a329"
    
    private init() {}
    
    func loadCities(with ids: [String], completion: @escaping (Result<CitiesResponse, Error>) -> Void) {
        guard let url = url(for: ids) else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result  = try decoder.decode(CitiesResponse.self, from: data)
                completion(.success(result))
                print(result)
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func loadCity(with name: String, completion: @escaping (Result<CityResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=metric&appid=\(Self.appId)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result  = try decoder.decode(CityResponse.self, from: data)
                completion(.success(result))
                print(result)
            } catch let error {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
    
    private func url(for ids: [String]) -> URL? {
        var ids = ids.reduce("") { result, current in
            return result + current + ","
        }
        
        if ids.last == "," {
            _ = ids.popLast()
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/group?id=\(ids)&units=metric&appid=\(Self.appId)"
        
        return URL(string: urlString)
    }
    
}
