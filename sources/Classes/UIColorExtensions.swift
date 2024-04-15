//
//  UIColorExtensions.swift
//  SBKit-swift
//
//  Created by ankang on 2023/7/5.
//

import Foundation

public extension UIColor {
    
    convenience init?(hexColor: uint, alpha: CGFloat = 1) {
        self.init(red: CGFloat((hexColor & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexColor & 0xFF00) >> 8) / 255.0,
                  blue: CGFloat(hexColor & 0xFF) / 255.0,
                  alpha: alpha)
        
    }
    
    convenience init?(red8Bit: CGFloat, green8Bit: CGFloat, blue8Bit: CGFloat, alpha: CGFloat = 1) {
        self.init(red: red8Bit / 255.0,
                  green: green8Bit / 255.0,
                  blue: blue8Bit / 255.0,
                  alpha: alpha)
        
    }
}
