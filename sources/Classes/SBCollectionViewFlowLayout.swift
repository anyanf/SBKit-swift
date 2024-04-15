//
//  SBCollectionViewFlowLayout.swift
//  SBKit-swift
//
//  Created by AnKang on 2023/7/9.
//

import Foundation

public class SBCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var sb_attributes = [SBCollectionViewLayoutAttributes]()
    
    public override init() {
        super.init()
        
        register(SBCollectionDecorationView.self, forDecorationViewOfKind: "SBCollectionDecorationView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        
        super.prepare()
        
        //Section个数
        guard let collectionView = collectionView else { return }
        let numberOfSections = collectionView.numberOfSections
        guard let delegate = collectionView.delegate as? SBCollectionViewDelegateFlowLayout
        else {
            return
        }
        sb_attributes.removeAll()
        for section in 0..<numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            
            var sectionFrame: CGRect?
            for row in 0..<numberOfItems {
                let itemAttr = layoutAttributesForItem(at: IndexPath(item: row, section: section))
                if let _ = sectionFrame {
                    if let itemAttr = itemAttr {
                        sectionFrame = sectionFrame?.union(itemAttr.frame)
                    }
                } else {
                    sectionFrame = itemAttr?.frame
                }

            }
            
            var sectionInset = self.sectionInset
            if let inset = delegate.collectionView?(collectionView, layout: self, insetForSectionAt: section) {
                sectionInset = inset
            }
            
            // 要不要加header和footer需要思考一下
//            if let sectionHeaderAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: section)) {
//                sectionFrame = sectionFrame.union(sectionHeaderAttr.frame)
//            }
//
//            if let sectionFooterAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: section)) {
//                sectionFrame = sectionFrame.union(sectionFooterAttr.frame)
//            }

            sectionFrame?.origin.x -= sectionInset.left
            sectionFrame?.size.width += sectionInset.left + sectionInset.right
            sectionFrame?.origin.y -= sectionInset.top
            sectionFrame?.size.height += sectionInset.top + sectionInset.bottom

            
            // 2、定义视图属性
            let attr = SBCollectionViewLayoutAttributes(forDecorationViewOfKind: "SBCollectionDecorationView", with: IndexPath(item: 0, section: section))
            attr.frame = sectionFrame ?? CGRect.zero
            attr.zIndex = -1
            if let bgInset = delegate.collectionView?(collectionView, layout: self, decorationInsetForSectionAt: section) {
                attr.frame.origin.x += bgInset.left
                attr.frame.size.width -= bgInset.left + bgInset.right
                attr.frame.origin.y += bgInset.top
                attr.frame.size.height -= bgInset.top + bgInset.bottom
            }
            
            
            attr.decorationBGColor = delegate.collectionView?(collectionView, layout: self, decorationBgColorForSectionAt: section)
            sb_attributes.append(attr)
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        var allAttributes = [UICollectionViewLayoutAttributes]()
        allAttributes.append(contentsOf: attributes)
        for att in sb_attributes {
            if rect.intersects(att.frame) {
                allAttributes.append(att)
            }
        }
        return allAttributes
    }
}


@objc public protocol SBCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {

    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, decorationInsetForSectionAt section: Int) -> UIEdgeInsets
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, decorationBgColorForSectionAt section: Int) -> UIColor

}
