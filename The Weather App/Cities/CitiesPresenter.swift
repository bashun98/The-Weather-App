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
    private var loadedCities = UserDefaults.standard.array(forKey: "addedCities") as? [String] ?? []
    
    init(router: CitiesRouterInput, interactor: CitiesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CitiesPresenter: CitiesModuleInput {
}

extension CitiesPresenter: CitiesViewOutput {
    
    func didRefresh() {
        interactor.loadCities()
    }
    
    func didTapAddButton() {
        router.showAddCity { [weak interactor] text in
            interactor?.loadCity(with: text)
            self.loadedCities.append(text)
            UserDefaults.standard.set(self.loadedCities, forKey: "addedCities")
        }
    }
    
    var itemsCount: Int {
        return viewModel.count
    }
    
    func item(at index: Int) -> CityViewModel {
        return viewModel[index]
    }
    
    func didLoadView() {
        for element in loadedCities {
            interactor.loadCity(with: element)
        }
    }
    
}

extension CitiesPresenter: CitiesInteractorOutput {
    func didLoad(cities: [CityResponse]) {
        viewModel = cities.map { CityViewModel(with: $0) }
        view?.reloadData()
    }
    
    func didLoad(city: CityResponse) {
        viewModel.append(CityViewModel(with: city))
        view?.reloadData()
    }
    
    func didFail(with error: Error) {
        router.showError(with: error.localizedDescription)
    }
}
