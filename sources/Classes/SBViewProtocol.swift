//
//  SBViewProtocol.swift
//  FBDetail
//
//  Created by AnKang on 2023/7/9.
//

import Foundation

public protocol SBViewProtocol {
        
    static func viewHeight(maxSize: CGSize?) -> CGFloat
    
    static func viewHeight(with model: Any?, maxSize: CGSize?) -> CGFloat
    
    static func viewSize(maxSize: CGSize?) -> CGSize
    
    static func viewSize(with model: Any?, maxSize: CGSize?) -> CGSize
    
    func handleModel(model: Any?)
}

public extension SBViewProtocol {
    
    static func viewHeight(maxSize: CGSize?) -> CGFloat {
        return 0
    }
    
    static func viewHeight(with model: Any?, maxSize: CGSize?) -> CGFloat {
        return 0
    }
    
    static func viewSize(maxSize: CGSize?) -> CGSize {
        return CGSize.zero
    }
    
    static func viewSize(with model: Any?, maxSize: CGSize?) -> CGSize {
        return CGSize.zero
    }
    
    
    func handleModel(model: Any?) {
        
    }

}
