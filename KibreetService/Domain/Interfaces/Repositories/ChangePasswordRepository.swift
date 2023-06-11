//
//  ChangePasswordRepository.swift
//  kabreet
//
//  Created by Essam Orabi on 16/04/2023.
//

import Foundation
import Combine

struct ChangePasswordRepository: ChangePasswordProtocol {
    func changePassword(currentPassword: String, newPassword: String) -> Future<changePassModel, Error> {
        ApiManager().apiCall(endPoint: ChangePassEndPoint(currentPass: currentPassword, newPass: newPassword))
    }
}
