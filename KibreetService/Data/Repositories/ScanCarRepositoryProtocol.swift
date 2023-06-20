//
//  ScanCarRepositoryProtocol.swift
//  KibreetService
//
//  Created by Essam Orabi on 14/06/2023.
//

import Foundation
import Combine


protocol ScanCarRepositoryProtocol {
    func uploadScanningCarInfo(driverCode: Int, vehicleNfc: String) -> Future<ScanCarModel, Error>
}
