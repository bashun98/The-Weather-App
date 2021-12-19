//
//  ViewController.swift
//  The Weather App
//
//  Created by Евгений Башун on 26.11.2021.
//

import UIKit
import PinLayout
import SDWebImage

class CityViewController: UIViewController {
    
    private let model: CityViewModel

    private let container = UIView()
    private let cityNameLabel = UILabel()
    private let humidityLabel = UILabel()
    private let pressureLabel = UILabel()
    private let feelsLikeLabel = UILabel()
    private let tempLabel = UILabel()
    private let tempMaxLabel = UILabel()
    private let tempMinLabel = UILabel()
    private let cityImageView = UIImageView()
    
    
    init(model: CityViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(container)
        [cityNameLabel, cityImageView, humidityLabel, pressureLabel, feelsLikeLabel, tempLabel, tempMaxLabel, tempMinLabel].forEach {
            container.addSubview($0)
        }
        cityImageView.backgroundColor = .red
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout(){
        container.pin
            .top()
            .width(UIScreen.main.bounds.width)
            .bottom()
        cityNameLabel.pin
            .hCenter()
            .top(15)
            .sizeToFit()
        cityImageView.pin
            .hCenter()
            .top(50)
            .width(of: container)
            .height(200)
        tempLabel.pin
            .center()
            .sizeToFit()
        tempMinLabel.pin
            .hCenter()
            .below(of: tempLabel)
            .sizeToFit()
        tempMaxLabel.pin
            .hCenter()
            .below(of: tempMinLabel)
            .sizeToFit()
        feelsLikeLabel.pin
            .hCenter()
            .below(of: tempMaxLabel)
            .sizeToFit()
        humidityLabel.pin
            .hCenter()
            .below(of: feelsLikeLabel)
            .sizeToFit()
        pressureLabel.pin
            .hCenter()
            .below(of: humidityLabel)
            .sizeToFit()
    }
    
    private func setupViews() {
        cityNameLabel.text = model.title
        humidityLabel.text = "Humadity = " + model.humidity
        pressureLabel.text = "Pressure = " + model.pressure
        feelsLikeLabel.text = "Feels Like = " + model.feelsLike
        tempLabel.text = "Temperature = " + model.temp
        tempMaxLabel.text = "Max temp. = " + model.tempMax
        tempMinLabel.text = "Min temp. = " + model.tempMin
        cityImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cityImageView.sd_setImage(with: model.image)

        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        cityNameLabel.textColor = .black
        
        [humidityLabel, pressureLabel, feelsLikeLabel, tempLabel, tempMaxLabel, tempMinLabel].forEach {
            $0.font = .systemFont(ofSize: 25)
            $0.textColor = .black
        }
    }
}
