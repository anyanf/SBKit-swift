//
//  SBCollectionDecorationView.swift
//  SBKit-swift
//
//  Created by AnKang on 2023/7/9.
//

import Foundation

public class SBCollectionDecorationView: UICollectionReusableView {
    
    lazy var subView = UIView()
    
    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let att = layoutAttributes as? SBCollectionViewLayoutAttributes {
            
            backgroundColor = att.decorationBGColor
            
        }
    }
}
