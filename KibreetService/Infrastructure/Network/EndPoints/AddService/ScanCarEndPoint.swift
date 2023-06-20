//
//  ScanCarEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 14/06/2023.
//

import Foundation

struct ScanCarEndPoint: BaseEndPointProtocol {
    
    init(driverCode: Int, vehicleNfc: String) {
        parameters = ["vehicleNfc":vehicleNfc,
                      "driverCode": driverCode
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
        return "app/worker/scan"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
