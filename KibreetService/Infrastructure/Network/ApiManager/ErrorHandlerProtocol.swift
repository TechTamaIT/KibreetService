//
//  ErrorHandlerProtocol.swift
//  ApiDataStrategy
//
//  Created by 2p on 3/15/22.
//

import Foundation

public protocol ErrorHandlerProtocol {
    func handleError(error: Error)
}

public enum CustomError: Error {
    
    case parseingError
    case internetConnectionError
    
    public var localizedDescription: String {
        switch self {
        case .internetConnectionError:
            return NSLocalizedString("No internet connection", comment: "No internet connection")
        case .parseingError:
            return NSLocalizedString("Error in parsing", comment: "Error in parsing")
        }
    }
}

