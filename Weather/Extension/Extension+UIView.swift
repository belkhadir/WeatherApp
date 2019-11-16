//
//  Extension+UIView.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

extension UIView {
    
    func autoLayout(topAnchor: NSLayoutYAxisAnchor?, bottomAnchor: NSLayoutYAxisAnchor?,
                    leadingAnchor: NSLayoutXAxisAnchor?, trailingAnchor: NSLayoutXAxisAnchor?,
                    margin: UIEdgeInsets = .zero, height: (NSLayoutDimension, CGFloat)? = nil, width: (NSLayoutDimension, CGFloat)? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: margin.top).isActive = true
        }
        
        if let bottomAnchor = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin.bottom).isActive = true
        }
        
        if let leadingAnchor = leadingAnchor {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin.left).isActive = true
        }
        
        if let traillingAnchor = trailingAnchor {
            self.trailingAnchor.constraint(equalTo: traillingAnchor, constant: -margin.right).isActive = true
        }
        
        if let height = height{
            self.heightAnchor.constraint(equalTo: height.0, multiplier: height.1).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalTo: width.0, multiplier: width.1).isActive = true
        }
        
        
    }
    
    func fillSuperView() {
        autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor)
    }
    
}
