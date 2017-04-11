//
//  H5VCRouter.swift
//  zhende
//
//  Created by chenliang on 2016/12/19.
//  Copyright © 2016年 chenliang. All rights reserved.
//

import Foundation


class H5VCRouter {
    
    // MARK : - 获取正式url地址
    func getRealWebViewUrl(routerKey:String,params:[String:String]) -> String {
        let router = RouterConfig.instance.getRouterFromKey(routerKey: routerKey)
        
        if router == nil {
            return ""
        }
        
        var paramsString = "?appVersion=\(api_version)"
        for (key, value) in params {
            let utf8Str = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as String
            paramsString  = "\(paramsString)&\(key)=\(utf8Str)"
        }
        
        var webViewUrl = (router?.routerUrl)! as String
        
        if paramsString != "" {
            webViewUrl = "\(webViewUrl)\(paramsString)"
        }
        
        return webViewUrl
    }
    
    func getAppParams(requestUrl:String) -> Any?{
        let querys = requestUrl.components(separatedBy: "&")
        
        for item in querys {
            let items = item.components(separatedBy: "=")
            
            if items[0] == "app" {
                let paramsValue = items[1]
                
                if let paramsValueDecoding = paramsValue.removingPercentEncoding {
                    print(paramsValueDecoding)
                    
                    if let encodeData = paramsValueDecoding.data(using: String.Encoding.utf8),
                        let obj = try? JSONSerialization.jsonObject(with: encodeData, options: JSONSerialization.ReadingOptions.allowFragments) {
                        
                        debugPrint(obj)
                        return obj
                        
                    }
                }
            }
        }
        
        return nil
    }
    
    // MARK : - 跳转到router对应的viewController
    private func pushToRouterVC(currentVC: UIViewController,params:[String:String],router:Router)  {
        
        switch router.openType {
        case .present:
            //将控制器名转换为类
            let vc = swiftClassFromString(className: router.routerVC)
            vc?.webviewPassParams = params
            let vcNav = UINavigationController(rootViewController: vc!)
//            vcNav.modalTransitionStyle = .crossDissolve
            currentVC.present(vcNav, animated: false, completion: nil)
            break
        case .push:
            //将控制器名转换为类
            let vc = swiftClassFromString(className: router.routerVC)
            vc?.webviewPassParams = params
            vc?.hidesBottomBarWhenPushed = true
            currentVC.navigationController?.pushViewController(vc!, animated: true)
            break
        }
    }
    
    private func pushToCommonWebVC(currentVC: UIViewController,url:String)  {
        let vc = CommonWebViewController()
        vc.commonUrl = url
        vc.hidesBottomBarWhenPushed = true
        currentVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToNewVC(currentVC : UIViewController,params:[String:String],routerKey:String) {
        let router = RouterConfig.instance.getRouterFromKey(routerKey: routerKey)
        if router != nil {
            
            if (router?.needToValidataToken)! {
                if let token = RealmOperate.getConfig(key: appConfig_user_token) {
                    if token == "" {
                        pushToNewVC(currentVC: currentVC, params: [:], routerKey: AppRouterKeys.login)
                    }else{
                         pushToRouterVC(currentVC: currentVC, params: params, router: router!)
                    }
                }else{
                    pushToNewVC(currentVC: currentVC, params: [:], routerKey: AppRouterKeys.login)
                }
            }else{
                pushToRouterVC(currentVC: currentVC, params: params, router: router!)
            }
           
        }else {
            var paramsString = "?appVersion=\(api_version)"
            for (key, value) in params {
                paramsString  = "\(paramsString)&\(key)=\(value)"
            }
            let url = "\(webviewUrlPrex)\(routerKey)\(paramsString)"
            pushToCommonWebVC(currentVC: currentVC, url: url)
    
        }
    }
    
    func swiftClassFromString(className: String) -> BaseViewController! {
        // get the project name
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            //拼接控制器名
            let classStringName = "\(appName).\(className)"
            //将控制名转换为类
            let classType = NSClassFromString(classStringName) as? BaseViewController.Type
            if let type = classType {
                let newVC = type.init()
                return newVC
            }
        }
        return nil;
    }
}
