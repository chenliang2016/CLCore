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

struct Router {
    var routerUrl : String
    var routerVC : String
    var openType : RouterOpenType
    var needToValidataToken : Bool = false
}

class RouterConfig {
    static let instance = RouterConfig()
    var routers : [String:Router] = [:]
}

extension RouterConfig {
    func initRouter(routers : [String:Router]) {
        self.routers = routers
    }
    
    func getRouterFromKey(routerKey:String) -> Router? {
        return RouterConfig.instance.routers[routerKey]
    }
}
