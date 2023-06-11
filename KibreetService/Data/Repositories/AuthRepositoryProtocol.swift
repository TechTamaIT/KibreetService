//
//  AuthRepositoryProtocol.swift
//  kabreet
//
//  Created by Essam Orabi on 07/04/2023.
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    func loginApi(email: String, password: String, accountType: Int) -> Future<LoginModel,Error>
}
