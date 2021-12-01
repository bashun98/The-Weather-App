//
//  CitiesPresenter.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//  
//

import Foundation

final class CitiesPresenter {
	weak var view: CitiesViewInput?
    weak var moduleOutput: CitiesModuleOutput?

	private let router: CitiesRouterInput
	private let interactor: CitiesInteractorInput
    
    private var viewModel: [CityViewModel] = []

    init(router: CitiesRouterInput, interactor: CitiesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CitiesPresenter: CitiesModuleInput {
}

extension CitiesPresenter: CitiesViewOutput {
    var itemsCount: Int {
        return viewModel.count
    }
    func item(at index: Int) -> CityViewModel {
        return viewModel[index]
    }
    func didLoadView() {
        interactor.loadCities()
    }
}

extension CitiesPresenter: CitiesInteractorOutput {
    func didLoad(cities: [CityResponse]) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        viewModel = cities.map {
            CityViewModel(title: $0.name,
                          time: dateFormatter.string(from: .init()),
                          icon: $0.weather.first?.icon,
                          temp: "\(Int($0.main.temp))˚C")
        }
        view?.reloadData()
    }
    
    func didFail(with error: Error) {
        
    }
}
