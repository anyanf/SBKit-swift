//
//  SBPresentationNavController.swift
//  FBDetail
//
//  Created by zhangbeibei on 2024/1/12.
//

import Foundation

public class SBPresentationNavController: UINavigationController {
    lazy var sb_viewRect: CGRect = {
        let screenSize = UIScreen.main.bounds.size
        let y = UIApplication.sb_navigationFullHeight() + 150
        let sb_viewRect = CGRect(x: 0, y: y, width: screenSize.width - 0 * 2, height: screenSize.height - y)
        return sb_viewRect
    }()
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        self.navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SBPresentationNavController : UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = SBPresentationController(presentedViewController: presented, presenting: presenting)
        vc.sb_presentedViewFrame = sb_viewRect
        return vc
    }
}
