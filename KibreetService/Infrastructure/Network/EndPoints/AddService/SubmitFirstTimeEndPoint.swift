//
//  SubmitFirstTimeEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 17/07/2023.
//

import Foundation


struct SubmitFirstTimeEndPoint: BaseEndPointProtocol {
    var httpMethod: HttpMethod {
        return .post
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
        return "app/worker/vehicle-types"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
