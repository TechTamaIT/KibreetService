//
//  ScanCarRepository.swift
//  KibreetService
//
//  Created by Essam Orabi on 14/06/2023.
//

import Foundation
import Combine

struct ScanCarRepository: ScanCarRepositoryProtocol {
    func uploadScanningCarInfo(driverCode: Int, vehicleNfc: String) -> Future<ScanCarModel, Error> {
        return ApiManager().apiCall(endPoint: ScanCarEndPoint(driverCode: driverCode, vehicleNfc: vehicleNfc))
    }
}
