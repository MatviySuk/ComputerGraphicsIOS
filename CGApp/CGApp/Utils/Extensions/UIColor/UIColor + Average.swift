//
//  UIColor + average.swift
//  CGApp
//
//  Created by Matviy Suk on 25.09.2022.
//

import UIKit

extension UIColor {
    func getAverageColorWith(_ color: UIColor) -> UIColor {
        let displacementRange = 1.0...1.0
//        var lr = CGFloat.zero
//        var lg = CGFloat.zero
//        var lb = CGFloat.zero
//        var la = CGFloat.zero
//
//        var rr = CGFloat.zero
//        var rg = CGFloat.zero
//        var rb = CGFloat.zero
//        var ra = CGFloat.zero
//
//        if self.getRed(&lr, green: &lg, blue: &lb, alpha: &la)
//            && color.getRed(&rr, green: &rg, blue: &rb, alpha: &ra) {
//            return .init(
//                red: lr.powAvrgWith(rr) * Double.random(in: displacementRange),
//                green: lg.powAvrgWith(rg) * Double.random(in: displacementRange),
//                blue: lb.powAvrgWith(rb) * Double.random(in: displacementRange),
//                alpha: la.powAvrgWith(ra)// * Double.random(in: displacementRange)
//            )
//        }
        
        var lh = CGFloat.zero
        var ls = CGFloat.zero
        var lb = CGFloat.zero
        var la = CGFloat.zero
        
        var rh = CGFloat.zero
        var rs = CGFloat.zero
        var rb = CGFloat.zero
        var ra = CGFloat.zero
        
        if self.getHue(&lh, saturation: &ls, brightness: &lb, alpha: &la)
            && color.getHue(&rh, saturation: &rs, brightness: &rb, alpha: &ra) {
            return .init(
                hue: lh.powAvrgWith(rh) * Double.random(in: displacementRange),
                saturation: ls.powAvrgWith(rs),// * Double.random(in: displacementRange),
                brightness: lb.powAvrgWith(rb),// * Double.random(in: displacementRange),
                alpha: la.powAvrgWith(ra)// * Double.random(in: displacementRange)
            )
        }
        
        return .black
    }
}

fileprivate extension CGFloat {
    func powAvrgWith(_ value: CGFloat) -> CGFloat {
        sqrt((pow(self, 2) + pow(value, 2)) / 2)
    }
}
