//
//  Model.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//

import Foundation

struct CitiesResponse: Decodable {
    let list: [CityResponse]
}

struct CityResponse: Decodable {
    let name: String
    let id: Int
    let time: Double
    let main: CityMainInfo
    let sys: CitySysInfo
    let weather: [CityWeather]
    let timeZone: Double
    let visibility: Int
    
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case timeZone = "timezone"
        case name
        case id
        case main
        case sys
        case weather
        case visibility
    }
}

struct CityMainInfo: Decodable {
    let temp: Float
    let feelsLike: Float
    let pressure: Float
    let humidity: Float
    let tempMax: Float
    let tempMin: Float
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case temp
        case pressure
        case humidity
    }
}

struct CitySysInfo: Decodable {
    let country: String
}

struct CityWeather: Decodable {
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "main"
    }
}
