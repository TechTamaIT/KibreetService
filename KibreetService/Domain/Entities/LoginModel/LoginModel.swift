//
//  LoginModel.swift
//  kabreet
//
//  Created by Essam Orabi on 31/03/2023.
//

import Foundation

struct LoginModel: Codable {
    let accessToken, refreshToken, message: String?
}
