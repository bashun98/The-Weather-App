//
//  CityViewModel.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//

import Foundation
import FirebaseStorage

struct CityViewModel {
    let title: String
    let time: String
    let temp: String
    let country: String
    let image: StorageReference
    let pressure: String
    let humidity: String
    let tempMax: String
    let tempMin: String
    let feelsLike: String
    
    init(with city: CityResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "HH:mm"
        
        let date = Date(timeIntervalSince1970: city.time + city.timeZone)
               
        let storageRef = Storage.storage().reference()
        let imageString = city.weather.first?.image ?? ""
        let starsRef = storageRef.child("\(imageString).jpg")
        
        self.title = city.name
        self.time = dateFormatter.string(from: date)
        self.temp = "\(Int(city.main.temp))˚C"
        self.country = city.sys.country
        self.image = starsRef
        self.humidity = "\(city.main.humidity) %"
        self.pressure = "\(city.main.pressure) MPa"
        self.tempMax = "\(city.main.tempMax)˚C"
        self.tempMin = "\(city.main.tempMin)˚C"
        self.feelsLike = "\(city.main.feelsLike)˚C"
    }
}
