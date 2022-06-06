//
//  CustomLabel.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import Foundation
import UIKit

@IBDesignable class CustomLabel: UILabel {
    
    @IBInspectable var isCircleImage: Bool = false {
        didSet {
            layer.cornerRadius = (frame.width + frame.height) / 4
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCircleImage {
            layer.cornerRadius = (frame.width + frame.height) / 4
        }
    }
}
