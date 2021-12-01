//
//  ViewController.swift
//  The Weather App
//
//  Created by Евгений Башун on 26.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherManager.shared.loadCities(with: ["524901", "292223"]) { result in
            print(result)
        }
        // Do any additional setup after loading the view.
    }


}

