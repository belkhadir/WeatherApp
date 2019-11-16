//
//  DailyTableViewCell.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class DailyTableViewCell: BaseTableViewCell {
    
    // Mark: - Instance Properties
    private let dayLabel = getLabel(fontName: "HelveticaNeue-Bold", size: 21)
    private var iconImageView = UIImageView()
    private let heighTemperatureLabel = getLabel(fontName: "HelveticaNeue", size: 21)
    private let lowTemperatureLabel = getLabel(fontName: "HelveticaNeue", size: 21)
    private let summryLabel = getLabel(fontName: "HelveticaNeue-Light", size: 17)
    
    // Mark: - Method
    func configure(cell with: BlockDataDailyModelView) {
        dayLabel.text = with.day
        iconImageView.image = UIImage.animatedImage(with: with.iconImages, duration: 0.75)
        heighTemperatureLabel.text = with.heighTemperature
        lowTemperatureLabel.text = with.lowTemperature
        summryLabel.text = with.summry
    }
    
    // Mark: - Setup Layout
    override func setupLayout() {
        super.setupLayout()
        summryLabel.numberOfLines = 0
        
        let temperatureStack = UIStackView(arrangedSubviews: [heighTemperatureLabel, lowTemperatureLabel])
        temperatureStack.axis = .horizontal
        temperatureStack.distribution = .equalSpacing
        
        temperatureStack.translatesAutoresizingMaskIntoConstraints = false
        temperatureStack.widthAnchor.constraint(equalToConstant: 80).isActive = true

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 31).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        iconImageView.contentMode = .scaleAspectFit
        
        
        
        let topStackView = UIStackView(arrangedSubviews: [dayLabel, temperatureStack])
        topStackView.alignment = .fill
        topStackView.distribution = .equalSpacing
        topStackView.axis = .horizontal
        
        
        let bottomStackView = UIStackView(arrangedSubviews: [iconImageView, summryLabel])
        bottomStackView.alignment = .center
        bottomStackView.distribution = .fill
        bottomStackView.axis = .horizontal
        
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        mainStackView.alignment = .fill
        mainStackView.distribution = .equalSpacing
        mainStackView.axis = .vertical
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, margin: .init(top: 6, left: 16, bottom: 6, right: 12))
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
}

