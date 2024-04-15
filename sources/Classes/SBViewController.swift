//
//  SBViewController.swift
//  SBKit-swift
//
//  Created by ankang on 2023/9/27.
//

import Foundation

open class SBViewController : UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

    }
    
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
