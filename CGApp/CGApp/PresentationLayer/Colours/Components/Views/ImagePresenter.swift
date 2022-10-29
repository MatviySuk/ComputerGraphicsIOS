//
//  ImagePresenter.swift
//  CGApp
//
//  Created by Matviy Suk on 28.10.2022.
//

import UIKit

final class ImagePresenter: UIView {

    init(uiImage: UIImage) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        self.layer.contents = uiImage.cgImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
