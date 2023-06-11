//
//  CarInfoEndPoint.swift
//  kabreet
//
//  Created by Essam Orabi on 10/04/2023.
//

import Foundation

struct CarInfoEndPoint: BaseEndPointProtocol {
    
    init(onGoing: Bool) {
        parameters = ["ongoing": onGoing]
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var parameters: [String : Any]?
    
    var headers: [String : String] {
        return [
            "lang":LanguageManager.languageId,
            "Authorization": "Bearer \(UserInfoManager.shared.user?.token ?? "")"
        ]
    }
    
    var encoding: Encoding {
        return .URL
    }
    
    var path: String {
        return "app/worker/visits"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
