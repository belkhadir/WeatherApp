//
//  BlockDataDailyModelView.swift
//  Weather
//
//  Created by swiftios01 on 16/11/2019.
//  Copyright © 2019 Babel. All rights reserved.
//

import UIKit


class BlockDataDailyModelView {
    
    private let formater = DateFormatter()
    
    let heighTemperature: String
    let lowTemperature: String
    let day: String
    let imageName: String
    let summry: String
    
    init(blockdataDaily: BlockDataDaily) {
        
        formater.dateFormat = "EEEE"
        heighTemperature = String(format:"%.0f" + "°", blockdataDaily.temperatureMax ?? 0)
        lowTemperature = String(format:"%.0f" + "°", blockdataDaily.temperatureMin ?? 0)
        
        day = formater.string(from: blockdataDaily.time!)
        
        imageName = blockdataDaily.icon ?? ""
        summry = blockdataDaily.summary ?? ""
    }
    
    var iconImages: [UIImage] {
        return ImageFacotory(string: imageName)?.images ?? [UIImage]()
    }
}
