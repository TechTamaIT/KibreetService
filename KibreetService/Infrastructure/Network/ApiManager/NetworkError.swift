//
//  File.swift
//  
//
//  Created by Mostafa Muhammad on 31/07/2022.
//

import Foundation

public class NetworkConnectionError : LocalizedError {
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }
}
