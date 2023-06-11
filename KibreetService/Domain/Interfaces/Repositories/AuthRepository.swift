//
//  AuthRepository.swift
//  kabreet
//
//  Created by Essam Orabi on 31/03/2023.
//

import Foundation
import Combine

struct AuthRepository: AuthRepositoryProtocol {
    func loginApi(email: String, password: String, accountType: Int) -> Future<LoginModel,Error> {
        return ApiManager().apiCall(endPoint: LoginEndPoint(email: email, password: password, accountType: accountType))
    }
}
