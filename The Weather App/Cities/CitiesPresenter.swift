//
//  CitiesPresenter.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//
//

import Foundation
import SwiftUI

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
    func didSelectItem(at index: Int) {
        let model = viewModel[index]
        router.openCity(model: model)
    }
    
    func deleteData(at index: Int) {
        loadedCities.remove(at: index)
        viewModel.remove(at: index)
        UserDefaults.standard.set(loadedCities, forKey: "addedCities")
        view?.reloadData()
    }
    
    func didRefresh() {
        view?.reloadData()
    }
    
    func didTapAddButton() {
        router.showAddCity { [weak interactor] text in
            if !self.loadedCities.contains(text) {
                interactor?.loadCity(with: text)
            } else {
                self.router.showError(with: "City has already been added")
            }
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
        if !loadedCities.contains(city.name) {
            loadedCities.append(city.name)
            UserDefaults.standard.set(loadedCities, forKey: "addedCities")
            viewModel.append(CityViewModel(with: city))
            view?.reloadData()
        } else {
            viewModel.append(CityViewModel(with: city))
            view?.reloadData()
        }
    }
    
    func didFail(with error: Error) {
        router.showError(with: "City does not exist")
    }
}
