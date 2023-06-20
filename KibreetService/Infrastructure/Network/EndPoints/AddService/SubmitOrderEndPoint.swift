//
//  SubmitOrderEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 13/06/2023.
//

import Foundation

struct SubmitOrderEndPoint: BaseEndPointProtocol {
    var visitId = 0
    
    init(visitId: Int, driverCode: Int) {
        self.visitId = visitId
        parameters = ["driverCode": driverCode]
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
        return "app/worker/submit/\(visitId)"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
