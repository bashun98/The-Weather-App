//
//  CityViewModel.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//

import Foundation

struct CityViewModel {
    let title: String
    let time: String
    let icon: URL?
    let temp: String
    
    init(with city: CityResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let iconString = city.weather.first?.icon ?? ""
        let urlString = URL(string: "https://openweathermap.org/img/wn/\(iconString)@2x.png")
        
        self.title = city.name
        self.time = dateFormatter.string(from: .init())
        self.icon = urlString
        self.temp = "\(Int(city.main.temp))˚C"
        
    }
}
