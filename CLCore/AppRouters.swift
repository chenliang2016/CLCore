//
//  AppRouters.swift
//  CLIOSFrame
//
//  Created by chenliang on 2017/1/1.
//  Copyright © 2017年 chenliang. All rights reserved.
//

import Foundation

struct AppRouterKeys {
    static var login = "/login"
    static var home = "/"
    static var reportNew = "/report/new"
}

class AppRouters {
    func getRouters() -> [String:Router] {
        var routers : [String:Router] = [:]
        
        routers[AppRouterKeys.login]  = Router(routerUrl: "\(webviewUrlPrex)/login", routerVC: "LoginViewController", openType: .present, needToValidataToken: false)
        
        routers[AppRouterKeys.home]  = Router(routerUrl: "\(webviewUrlPrex)/", routerVC: "HomeViewController", openType: .present, needToValidataToken: false)
        
        routers[AppRouterKeys.reportNew]  = Router(routerUrl: "\(webviewUrlPrex)/report/new", routerVC: "FireReportViewController", openType: .push, needToValidataToken: false)
        
        return routers
    }
}
