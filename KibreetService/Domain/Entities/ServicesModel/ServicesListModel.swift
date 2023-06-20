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
    let invoiceDetails: InvoiceDetails?
}

// MARK: - Service
struct Service: Codable {
    let id, serviceType, amount, vehicleKilometers: Int
    let serviceTypeName: String
    let images: [String]
}

// MARK: - Vehicle
struct Vehicle: Codable {
    let vehicleType: Int
    let vehicleTypeName, vehicleModel, plateNumber, oilViscosity: String
    let oilBrand, branchName: String
}

// MARK: - InvoiceDetails
struct InvoiceDetails: Codable {
    let id: Int
    let date, invoiceNumber, companyName, companyAddress: String
    let companyContactNumber, supplierName, supplierAddress, supplierContactNumber: String
    let branchId, serviceCenterId: Int
    let services: [InvoiceDetailsService]
    let tax, subtotal, total: Double
}

// MARK: - InvoiceDetailsService
struct InvoiceDetailsService: Codable {
    let name, description: String
    let price, amount: Double
}

