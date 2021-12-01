//
//  CitiesProtocols.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//  
//

import Foundation

protocol CitiesModuleInput {
	var moduleOutput: CitiesModuleOutput? { get }
}

protocol CitiesModuleOutput: AnyObject {
}

protocol CitiesViewInput: AnyObject {
    func reloadData()
}

protocol CitiesViewOutput: AnyObject {
    var itemsCount: Int { get }
    func item(at index: Int) -> CityViewModel
    func didLoadView()
}

protocol CitiesInteractorInput: AnyObject {
    func loadCities()
}

protocol CitiesInteractorOutput: AnyObject {
    func didLoad(cities: [CityResponse])
    func didFail(with error: Error)
}

protocol CitiesRouterInput: AnyObject {
}
