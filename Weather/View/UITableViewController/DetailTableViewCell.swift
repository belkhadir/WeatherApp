//
//  DetailTableViewCell.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class DetailTableViewCell: BaseTableViewCell {
    // Mark: - Instance Properties
    fileprivate let titleLabel = getLabel(fontName: "HelveticaNeue-Bold", size: 21)
    fileprivate let detailTitleLabel = getLabel(fontName: "HelveticaNeue", size: 21)
    fileprivate let imageViewIcon = UIImageView()
    
    // Mark: - Method
    func configure(cell with: (key: String, value: Any, icon: String)) {
         titleLabel.text = with.key
         detailTitleLabel.text = "\(with.value)"
         imageViewIcon.image = UIImage(named: with.icon)
    }

    
    
    // Mark: - Setup Layout
    override func setupLayout() {
        super.setupLayout()
        
        imageViewIcon.clipsToBounds = true
        imageViewIcon.contentMode = .scaleAspectFill
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, detailTitleLabel])
        labelStackView.alignment = .leading
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        
        
        let overAllStackView = UIStackView(arrangedSubviews: [imageViewIcon, labelStackView])
        overAllStackView.alignment = .leading
        overAllStackView.axis = .horizontal
        overAllStackView.distribution = .fill
        overAllStackView.spacing = 32
        
        addSubview(overAllStackView)
        
        overAllStackView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, margin: .init(top: 8, left: 12, bottom: 8, right: 12))

    }
}
