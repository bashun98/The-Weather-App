//
//  CitiesContainer.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//  
//

import UIKit

final class CitiesContainer {
    let input: CitiesModuleInput
	let viewController: UIViewController
	private(set) weak var router: CitiesRouterInput!

	class func assemble(with context: CitiesContext) -> CitiesContainer {
        let router = CitiesRouter()
        let interactor = CitiesInteractor()
        let presenter = CitiesPresenter(router: router, interactor: interactor)
		let viewController = CitiesViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return CitiesContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CitiesModuleInput, router: CitiesRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CitiesContext {
	weak var moduleOutput: CitiesModuleOutput?
}
