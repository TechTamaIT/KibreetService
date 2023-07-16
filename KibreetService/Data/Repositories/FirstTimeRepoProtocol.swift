//
//  FirstTimeRepoProtocol.swift
//  KibreetService
//
//  Created by Essam Orabi on 17/07/2023.
//

import Foundation
import Combine

protocol FirstTimeRepoProtocol {
    func getVehcileTypes() -> Future<[VehiclesTypeModel], Error>
    func submitFirstTimeScan(carPlateNo: String, vehicleType: Int, driverCode: String) -> Future<String, Error>
}
