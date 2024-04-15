//
//  SBRouter.swift
//  SBKit-swift
//
//  Created by AnKang on 2023/7/22.
//

import Foundation

import JLRoutes


public class SBRouter {

    public class func addRoute(_ routePattern: String, handler handlerBlock: (([String : Any]) -> Bool)? = nil) {
        JLRoutes.global().addRoute(routePattern, handler: handlerBlock)
    }
    
    public class func routeURL(routePattern: String, withParameters parameters: [String : Any]?) -> Bool {
        
        let url = URL(string: routePattern)
        return JLRoutes.global().routeURL(url, withParameters: parameters)
        
    }
}
