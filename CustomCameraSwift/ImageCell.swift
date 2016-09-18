//
//  ImageCell.swift
//  CustomCameraSwift
//
//  Created by Sinisa Vukovic on 17/09/16.
//  Copyright © 2016 Sinisa Vukovic. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet var uiImage: UIImageView!
    @IBOutlet var checkimage: UIImageView!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
    }
}
