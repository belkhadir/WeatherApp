//
//  Helper.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit

func getLabel(fontName: String, size: CGFloat) -> UILabel {
    let label = UILabel()
    label.font = UIFont(name: fontName, size: size)
    label.textColor = .white
    return label
}
