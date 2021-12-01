//
//  CityTableViewCell.swift
//  The Weather App
//
//  Created by Евгений Башун on 01.12.2021.
//

import UIKit
import PinLayout

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
        [titleLabel,tempLabel,iconImageView,titleLabel].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin.all()
        titleLabel.pin
            .bottom(8)
            .left(12)
            .height(40)
            .sizeToFit(.height)
        timeLabel.pin
            .above(of: titleLabel)
            .left(12)
            .height(20)
            .sizeToFit(.height)
    }
    
    public func configure(with viewModel: CityViewModel) {
        titleLabel.text = viewModel.title
        timeLabel.text = viewModel.time
        tempLabel.text = viewModel.temp
        
    }
}
