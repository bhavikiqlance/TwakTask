//
//  ShimmerOptions.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import UIKit

public class ShimmerOptions {
    public static let instance = ShimmerOptions()
    
    enum Direction {
        case topBottom
        case bottomTop
        case leftRight
        case rightLeft
    }
    
    enum AnimationType {
        case classic
        case fade
    }
    
    // Animation option
    var animationDuration: CGFloat = 1.0
    var animationDelay: CGFloat = 0.3
    var animationAutoReserse = true
    var animationDirection: Direction = .leftRight
    var animationType: AnimationType = .classic
    
    // Shimmer background option
    var gradientColor = UIColor.gray
    var borderWidth: CGFloat = 0.0
    var borderColor = UIColor.gray
    var backgroundColor = UIColor.white
    
    private init() { }
}
