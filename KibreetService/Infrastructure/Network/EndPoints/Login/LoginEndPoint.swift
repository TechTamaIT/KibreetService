//
//  LoginEndPoint.swift
//  kabreet
//
//  Created by Essam Orabi on 31/03/2023.
//

import Foundation

struct LoginEndPoint: BaseEndPointProtocol {
    
    
    var parameters: [String : Any]?
    
    init(email: String , password: String,accountType: Int) {
        parameters = ["email": email,
                      "password": password,
                      "accountType": accountType
        ]
     }
    
    var httpMethod: HttpMethod {
        return .post
    }
    
    var headers: [String : String] {
        return ["lang":LanguageManager.languageId]
    }
    
    var encoding: Encoding {
        return .JSON
    }
    
    var path: String {
        return "identity/login"
    }
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
