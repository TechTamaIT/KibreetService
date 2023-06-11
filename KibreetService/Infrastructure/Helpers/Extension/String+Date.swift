//
//  String+Date.swift
//  SFC
//
//  Created by Ahmed Labeeb on 07/09/2022.
//

import Foundation

extension String {
    func date(format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        let date = formatter.date(from: self)
        guard let date = date else{ return self}
        formatter.dateFormat = format
        let string = formatter.string(from: date) 
        return string
    }
}
extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
