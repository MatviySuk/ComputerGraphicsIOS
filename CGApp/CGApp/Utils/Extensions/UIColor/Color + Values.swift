//
//  Color + Values.swift
//  CGApp
//
//  Created by Matviy Suk on 04.10.2022.
//

import UIKit

extension UIColor {
    var hue: CGFloat {
        var hue: CGFloat = .zero
        
        self.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        
        return hue
    }
}
