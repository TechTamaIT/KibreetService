//
//  UpdateServiceEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 13/06/2023.
//

import Foundation

struct UpdateServiceEndPoint: BaseEndPointProtocol {
    
    var visitId = 0
    
    init(id:Int, visitId: Int, amount: Double, vehicleKilometers: Double) {
        self.visitId = visitId
        parameters = ["Id":id,
                      "Amount": amount,
                      "VehicleKilometers": vehicleKilometers
        ]
    }
    
    var httpMethod: HttpMethod {
        return .put
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
        return "app/worker/services/\(visitId)"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
