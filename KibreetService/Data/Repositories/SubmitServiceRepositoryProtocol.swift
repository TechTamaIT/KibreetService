//
//  SubmitServiceRepositoryProtocol.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

protocol SubmitServiceRepositoryProtocol {
    func submitService(visiteId: Int, availabilityId: Int, amount: Double, vehicleKilometers: Double, attachments: [Attachment]) -> Future<SubmitServiceModel, Error>
    
    func updateService(id: Int, visiteId: Int, amount: Double, vehicleKilometers: Double, attachments: [Attachment]) -> Future<SubmitServiceModel, Error>
}
