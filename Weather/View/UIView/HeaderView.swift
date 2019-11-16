//
//  HeaderView.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class HeaderView: UIView {
    // Mark: - Instance Properties
    fileprivate let titleLabel = getLabel(fontName: "HelveticaNeue-Bold", size: 51)
    fileprivate let summuryLabel = getLabel(fontName: "HelveticaNeue", size: 17)
    fileprivate let temperatureLabel = getLabel(fontName: "HelveticaNeue-Bold", size: 35)
    fileprivate let iconImageView = UIImageView()
    
    // Mark: - Object LifeCylce
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Method
    func configure(header city: CityModelView) {
        titleLabel.text = city.name
        temperatureLabel.text = city.temperatureString
        summuryLabel.text = city.summary
        iconImageView.image = UIImage.animatedImage(with: city.iconImages, duration: 0.75)
    }
    
    fileprivate func setupLayout() {
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let stackTemperature = UIStackView(arrangedSubviews: [temperatureLabel, summuryLabel])
        stackTemperature.alignment = .bottom
        stackTemperature.axis = .horizontal
        stackTemperature.distribution = .fill
        stackTemperature.spacing = 2
    
        
        let bottomStackView = UIStackView(arrangedSubviews: [iconImageView, stackTemperature])
        bottomStackView.alignment = .center
        bottomStackView.distribution = .fill
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 20
        
    
        let overAllStack = UIStackView(arrangedSubviews: [titleLabel, bottomStackView])
        overAllStack.alignment = .center
        overAllStack.distribution = .fill
        overAllStack.axis = .vertical
        overAllStack.spacing = 8
        
        overAllStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overAllStack)
        overAllStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        overAllStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
