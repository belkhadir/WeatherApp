//
//  CityTableViewCell.swift
//  Weather
//
//  Created by swiftios01 on 15/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

final class CityTableViewCell: BaseTableViewCell {
    // Mark: - Instance Properties
    fileprivate let cityLabel = getLabel(fontName: "HelveticaNeue", size: 31)
    fileprivate let temperatureLabel = getLabel(fontName: "HelveticaNeue", size: 42)
    fileprivate let summaryLabel = getLabel(fontName: "HelveticaNeue-Light", size: 21)
    fileprivate let imageBackground = UIImageView()
    
    // Mark: - Method
    func configure(cell with: CityModelView) {
        cityLabel.text = with.name
        temperatureLabel.text = with.temperatureString
        summaryLabel.text = with.summary
        backgroundView = with.imageView
    }
    
    // Mark: - BaseTableViewCell Method
    override func setupLayout() {
        super.setupLayout()
        
        let leftStackView = UIStackView(arrangedSubviews: [summaryLabel, cityLabel])
        leftStackView.alignment = .leading
        leftStackView.axis = .vertical
        leftStackView.distribution = .fill
        
        
        let overAllStackView = UIStackView(arrangedSubviews: [leftStackView, temperatureLabel])
        overAllStackView.alignment = .bottom
        overAllStackView.axis = .horizontal
        overAllStackView.distribution = .fill
        
        addSubview(overAllStackView)

        overAllStackView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, margin: .init(top: 12, left: 12, bottom: 12, right: 12))
                
    }

}
