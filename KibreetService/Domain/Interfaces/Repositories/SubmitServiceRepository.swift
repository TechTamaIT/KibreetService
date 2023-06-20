//
//  SubmitServiceRepository.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

struct SubmitServiceRepository: SubmitServiceRepositoryProtocol {
    func submitService(visiteId: Int, availabilityId: Int, amount: Double, vehicleKilometers: Double, attachments: [Attachment]) -> Future<SubmitServiceModel, Error> {
        return ApiMultipartHelper().apiCall(endPoint: SubmitServiceEndPoint(visitId: visiteId, availabilityId: availabilityId, amount: amount, vehicleKilometers: vehicleKilometers), attachments: attachments)
    }
    
    func updateService(id: Int, visiteId: Int, amount: Double, vehicleKilometers: Double, attachments: [Attachment]) -> Future<SubmitServiceModel, Error> {
        return ApiMultipartHelper().apiCall(endPoint: UpdateServiceEndPoint(id: id, visitId: visiteId, amount: amount, vehicleKilometers: vehicleKilometers), attachments: attachments)
    }
}
