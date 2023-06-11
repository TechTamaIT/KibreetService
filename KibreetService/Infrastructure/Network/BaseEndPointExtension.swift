//
//  BaseEndPointExtension.swift
//  kabreet
//
//  Created by Essam Orabi on 22/01/2023.
//

import Foundation


extension BaseEndPointProtocol {
    var baseUrl: String {
        //return Links.production
        return ""
    }
    
    var defaultHeaders: [String : String] {
//        return ["x-lang":LanguageHelper.getCurrentLanguage(),
//                "x-country":"sa"]
        return["":""]
    }
    
    var authorizedHeaders: [String : String] {
//        return ["x-lang":LanguageHelper.getCurrentLanguage(),
//                "x-country":"sa",
//                "Authorization": UserInfoManager.shared.user?.token ?? ""]
        return ["":""]
    }
    
    var encoding: Encoding{
        return Encoding.URL
    }
    
}
