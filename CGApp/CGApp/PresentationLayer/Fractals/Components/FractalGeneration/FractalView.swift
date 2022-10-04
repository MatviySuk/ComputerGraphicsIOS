//
//  FractalView.swift
//  CGApp
//
//  Created by Matviy Suk on 01.10.2022.
//

import UIKit
import SnapKit

class FractalView: UIView {
    var showFractal: Bool = false
        
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
