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
    
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case timeZone = "timezone"
        case name
        case id
        case main
        case sys
        case weather
    }
}

struct CityMainInfo: Decodable {
    let temp: Float
    let feelsLike: Float
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
    }
}

struct CitySysInfo: Decodable {
    let country: String
}

struct CityWeather: Decodable {
    let icon: String
}
