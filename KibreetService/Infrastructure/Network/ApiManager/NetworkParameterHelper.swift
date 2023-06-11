//
//  NetworkParameterHelper.swift
//  SFC
//
//  Created by Ahmed Elmansy on 05/10/2022.
//

import Foundation

class NetworkParameterHelper{
    
    private init() {}
    
    static func convertParameterArabicValuesToEnglish(of parameters: [String:Any])-> [String:Any]{
        var newParameters = parameters
        parameters.forEach { key,value in
            if let value = value as? String{
                newParameters[key] = getConvertedString(of: value)
            }
        }
        return newParameters
    }
    
    private static let dict:[String:String] = [
        "٠":"0",
        "١":"1",
        "٢":"2",
        "٣":"3",
        "٤":"4",
        "٥":"5",
        "٦":"6",
        "٧":"7",
        "٨":"8",
        "٩":"9"
    ]
    
    private static func getConvertedString(of string: String)-> String{
        var res = string
        dict.forEach { ar, en in
            res = res.replacingOccurrences(of: ar, with: en)
        }
        return res
    }
    
}
