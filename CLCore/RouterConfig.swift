//
//  RouterConfig.swift
//  CLIOSFrame
//
//  Created by chenliang on 2017/1/1.
//  Copyright © 2017年 chenliang. All rights reserved.
//

import Foundation

enum RouterOpenType {
    case push
    case present
}

public struct Router {
    var routerUrl : String
    var routerVC : String
    var openType : RouterOpenType
    var needToValidataToken : Bool = false
}

open class RouterConfig {
    static let instance = RouterConfig()
    var routers : [String:Router] = [:]
}

extension RouterConfig {
    public func initRouter(routers : [String:Router]) {
        self.routers = routers
    }
    
    public func getRouterFromKey(routerKey:String) -> Router? {
        return RouterConfig.instance.routers[routerKey]
    }
}
