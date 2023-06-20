//
//  InvoiceSummaryModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation

// MARK: - Welcome
struct InvoiceSummaryModel: Codable {
    let date, invoiceNumber, companyName, companyAddress: String
    let companyContactNumber, supplierName, supplierAddress, supplierContactNumber: String
    let services: [ServiceSummary]
    let tax, subtotal, total: Double
}

// MARK: - Service
struct ServiceSummary: Codable {
    let name, description: String
    let price, amount: Int
}
