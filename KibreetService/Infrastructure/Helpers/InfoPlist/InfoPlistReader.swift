//
//  InfoPlistReader.swift
//  SFC
//
//  Created by Ahmed Labeeb on 28/08/2022.
//

import Foundation

enum InfoPlistParameters: String {
    case baseURL = "BaseUrl"
    case merchantId = "MerchantId"
}


class InfoPlistReader {
    
    static func getValueForKey(key: InfoPlistParameters) -> String? {
        if let value = Bundle.main.infoDictionary?[key.rawValue] {
            return value as? String
        }
        return nil
    }
    
}
