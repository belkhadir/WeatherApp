//
//  DetailTableViewCell.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class DetailTableViewCell: BaseTableViewCell {

    func configure(cell with: (key: String, value: Any, icon: String)) {
         titleLabel.text = with.key
         detailTitleLabel.text = "\(with.value)"
         imageViewIcon.image = UIImage(named: with.icon)
    }


    fileprivate let titleLabel = getLabel(fontName: "HelveticaNeue-Bold", size: 21)
    fileprivate let detailTitleLabel = getLabel(fontName: "HelveticaNeue", size: 21)
    fileprivate let imageViewIcon = UIImageView()
    
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
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        
        overAllStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        overAllStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        overAllStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        overAllStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
}
