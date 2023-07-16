//
//  FirstTimeRepository.swift
//  KibreetService
//
//  Created by Essam Orabi on 17/07/2023.
//

import Foundation
import Combine

struct FirstTimeRepository: FirstTimeRepoProtocol {
    func getVehcileTypes() -> Future<[VehiclesTypeModel], Error> {
        return ApiManager().apiCall(endPoint: GetVehicleTypesEndPoint())
    }
    
    func submitFirstTimeScan(carPlateNo: String, vehicleType: Int, driverCode: String) -> Future<String, Error> {
        return ApiManager().apiCall(endPoint: SubmitFirstTimeEndPoint())
    }
}
