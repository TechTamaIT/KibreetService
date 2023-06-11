//
//  ServicesListModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation

struct ServicesListModel: Codable {
    let vehicle: Vehicle
    let services: [Service]
}

// MARK: - Service
struct Service: Codable {
    let id, serviceType, amount, vehicleKilometers: Int
    let images: [String]
}

// MARK: - Vehicle
struct Vehicle: Codable {
    let vehicleType: Int
    let vehicleTypeName, vehicleModel, plateNumber, oilViscosity: String
    let oilBrand, branchName: String
}

