//
//  KSItem.swift
//  CustomCameraSwift
//
//  Created by Sinisa Vukovic on 18/09/16.
//  Copyright © 2016 Sinisa Vukovic. All rights reserved.
//

import Foundation
import  UIKit

class KSItem {
    var itemName: String? = nil
    var itemLocation: String? = nil
    var valueInDollors: Double? = nil
    var photosArray:[UIImage]? = nil
    var description: String? = nil
    
    required init(name:String,  location: String, value:Double,description: String ,photos: Array<UIImage> ) {
        
        itemName = name
        itemLocation = location
        valueInDollors = value
        self.description = description
        photosArray = photos
    }
    
}




