//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by El Capitan on 9/2/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit

// based on the maximum height and width of an iPhone 7 Plus
extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
