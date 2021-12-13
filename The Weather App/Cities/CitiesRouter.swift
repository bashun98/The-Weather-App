//
//  CitiesRouter.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//
//

import UIKit

final class CitiesRouter {
    weak var viewController: UIViewController?
}

extension CitiesRouter: CitiesRouterInput {
    func showError(with text: String) {
        let alertController = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showAddCity(onAdd: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Add city", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
        }
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            guard let text = alertController.textFields?.first?.text else { return }
            onAdd(text)
        }))
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}
