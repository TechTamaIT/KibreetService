//
//  ChangePassEndPoint.swift
//  kabreet
//
//  Created by Essam Orabi on 16/04/2023.
//

import Foundation

struct ChangePassEndPoint: BaseEndPointProtocol {
    
    init(currentPass: String, newPass: String) {
        parameters = ["currentPassword": currentPass,
                      "newPassword": newPass,
                      "accountType": 4,
        ]
    }
    
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
        return .JSON
    }
    
    var path: String {
        return "Identity/change-password"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
    
}
