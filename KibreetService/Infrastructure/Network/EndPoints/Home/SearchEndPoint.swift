//
//  SearchEndPoint.swift
//  kabreet
//
//  Created by Essam Orabi on 07/04/2023.
//

import Foundation

struct SearchEndPoint: BaseEndPointProtocol {

    init(lat: Double , long: Double, distance: Double = 10000, searchKey: String) {
        parameters = ["Lat": lat,
                      "Lng": long,
                      "Distance": distance,
                      "SearchKey": searchKey
        ]
     }
    var httpMethod: HttpMethod {
        return .get
    }
    
    var encoding: Encoding {
        return .URL
    }
    
    var parameters: [String : Any]?
    
    var headers: [String : String] {
        return [
            "lang":LanguageManager.languageId,
            "Authorization": "Bearer \(UserInfoManager.shared.user?.token ?? "")"
        ]
    }
    
    var path: String {
        return "app/Driver/nearby-centers"
    }
    
    var apiVersion: String {
        return "1.0"
    }
    
    var url: URL {
        URL.init(string: NetworkConstant.baseURL + path)!
    }
    
    
}
