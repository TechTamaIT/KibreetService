//
//  DeleteServiceEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 13/06/2023.
//

import Foundation

struct DeleteServiceEndPoint: BaseEndPointProtocol {
    var visitId = 0
    
    init(visitId: Int, serviceId: Int) {
        self.visitId = visitId
        parameters = ["serviceId": serviceId]
    }
    
    var httpMethod: HttpMethod {
        return .delete
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
        return "app/worker/services/\(visitId)"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
