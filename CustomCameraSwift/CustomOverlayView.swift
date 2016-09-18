//
//  CustomOverlayView.swift
//  CustomCameraSwift
//
//  Created by Sinisa Vukovic on 14/09/16.
//  Copyright © 2016 Sinisa Vukovic. All rights reserved.
//

import UIKit

protocol CustomOverlayDelegate{
    func didCancel(_ overlayView:CustomOverlayView)
    func didShoot(_ overlayView:CustomOverlayView)
}

class CustomOverlayView: UIView {
    var delegate:CustomOverlayDelegate! = nil
    
    @IBAction func cancelButton(_ sender: UIButton) {
        delegate.didCancel(self)
    }
    @IBAction func shootButton(_ sender: UIButton) {
        delegate.didShoot(self)
    }
}
