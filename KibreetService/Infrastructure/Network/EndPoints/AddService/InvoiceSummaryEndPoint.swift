//
//  InvoiceSummaryEndPoint.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation

struct InvoiceSummaryEndPoint: BaseEndPointProtocol {
    var visitId = 0
    
    init(visitId: Int) {
        self.visitId = visitId
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
        return "app/worker/preview-invoice/\(visitId)"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: NetworkConstant.baseURL + path)!
    }
}
