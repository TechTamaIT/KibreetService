//
//  CarInfoModel.swift
//  kabreet
//
//  Created by Essam Orabi on 10/04/2023.
//

import Foundation

struct CarFullInfoModel: Codable {
    let visitId: Int
    let vehiclePlateNumber, vehicleOilType, visitDate: String
    let message: String?

}
