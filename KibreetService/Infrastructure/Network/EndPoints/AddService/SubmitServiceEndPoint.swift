//
//  SubmitServiceEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation

struct SubmitServiceEndPoint: BaseEndPointProtocol {
    var visitId = 0
    
    init(visitId: Int, availabilityId: Int, amount: Double, vehicleKilometers: Double) {
        self.visitId = visitId
        parameters = ["AvailabilityId": availabilityId,
                      "Amount": amount,
                      "VehicleKilometers": vehicleKilometers
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
        return "app/worker/services/\(visitId)"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
