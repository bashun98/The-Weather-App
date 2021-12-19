//
//  CityTableViewCell.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//

import UIKit
import PinLayout
import FirebaseStorageUI

class CityTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let tempLabel = UILabel()
    private let iconImageView = UIImageView()
    private let timeLabel = UILabel()
    private let containerView = UIView()
    private let countryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setup() {
        selectionStyle = .none
        addViews()
        setupContainer()
        setupFonts()
    }
    
    private func addViews() {
        contentView.addSubview(iconImageView)
        iconImageView.addSubview(containerView)
        [titleLabel, tempLabel, timeLabel, countryLabel].forEach {
            iconImageView.addSubview($0)
        }

        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = 8
    }
    
    private func setupFonts() {
        timeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.font = .systemFont(ofSize: 30, weight: .medium)
        tempLabel.font = .systemFont(ofSize: 36, weight: .medium)
        countryLabel.font = .systemFont(ofSize: 30, weight: .medium)
        [titleLabel, tempLabel, timeLabel, countryLabel].forEach {
            $0.textColor = .white
        }
    }
    
    private func setupContainer() {
//        containerView.layer.shadowColor = UIColor.black.cgColor
//        containerView.layer.shadowRadius = 0.5
//        containerView.layer.shadowOffset = .init(width: 0.5, height: 0.5)
//        containerView.layer.shadowOpacity = 0.8
//        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.pin
            .horizontally(8)
            .vertically(4)
        containerView.pin
            .horizontally()
            .vertically()
        titleLabel.pin
            .top(8)
            .left(12)
            .height(40)
            .sizeToFit(.height)
        countryLabel.pin
            .height(40)
            .sizeToFit(.height)
            .after(of: titleLabel, aligned: .bottom)
        timeLabel.pin
            .below(of: titleLabel, aligned: .left)
            .height(20)
            .sizeToFit(.height)
        tempLabel.pin
            .right(12)
            .height(64)
            .sizeToFit(.height)
            .vCenter()
    }
    
    public func configure(with viewModel: CityViewModel) {
        titleLabel.text = viewModel.title + ", "
        timeLabel.text = viewModel.time
        tempLabel.text = viewModel.temp
        iconImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        iconImageView.sd_setImage(with: viewModel.image)
        countryLabel.text = viewModel.country
    }
}
