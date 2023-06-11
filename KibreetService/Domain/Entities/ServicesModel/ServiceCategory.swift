//
//  ServiceCategory.swift
//  KibreetService
//
//  Created by Essam Orabi on 09/06/2023.
//

import Foundation

struct ServiceCategoryModel: Codable {
    let serviceCategory: ServiceCategory
    let centerServices: [CenterService]
}

// MARK: - CenterService
struct CenterService: Codable {
    let id: Int
    let name, description: String
    let centerPrice: Double
}

// MARK: - ServiceCategory
struct ServiceCategory: Codable {
    let id, serviceType: Int
    let description, serviceTypeName: String
}
