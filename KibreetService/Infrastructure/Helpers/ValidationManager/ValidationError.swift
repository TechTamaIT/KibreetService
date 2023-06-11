//
//  ValidationError.swift
//  ESports
//
//  Created by Mostafa Muhammad on 05/06/2022.
//

import Foundation

class ValidationError : LocalizedError {
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "Invalid Email")
    }

    
}
