//
//  ChangePasswordProtocol.swift
//  kabreet
//
//  Created by Essam Orabi on 16/04/2023.
//

import Foundation
import Combine

protocol ChangePasswordProtocol {
    
    func changePassword(currentPassword: String, newPassword: String) -> Future<changePassModel,Error>
    
}
