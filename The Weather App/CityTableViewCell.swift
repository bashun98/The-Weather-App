//
//  CityTableViewCell.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//

import UIKit
import PinLayout
import Kingfisher

class CityTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let tempLabel = UILabel()
    private let iconImageView = UIImageView()
    private let timeLabel = UILabel()
    private let containerView = UIView()
    
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
        [titleLabel,tempLabel,iconImageView,timeLabel].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    
    private func setupFonts() {
        timeLabel.font = .systemFont(ofSize: 26, weight: .semibold)
        titleLabel.font = .systemFont(ofSize: 40, weight: .medium)
        tempLabel.font = .systemFont(ofSize: 26, weight: .medium)
    }
    
    private func setupContainer() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 0.5
        containerView.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin
            .horizontally(12)
            .vertically(7)
        titleLabel.pin
            .bottom(8)
            .left(12)
            .height(40)
            .sizeToFit(.height)
        timeLabel.pin
            .top(12)
            .left(12)
            .height(20)
            .sizeToFit(.height)
        iconImageView.pin
            .size(60)
            .center()
        tempLabel.pin
            .right(12)
            .height(64)
            .sizeToFit(.height)
            .vCenter()
    }
    
    public func configure(with viewModel: CityViewModel) {
        titleLabel.text = viewModel.title
        timeLabel.text = viewModel.time
        tempLabel.text = viewModel.temp
        iconImageView.kf.setImage(with: viewModel.icon)
        
    }
}
