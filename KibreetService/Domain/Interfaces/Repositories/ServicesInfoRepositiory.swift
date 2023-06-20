//
//  ServicesInfoRepositiory.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

struct ServicesInfoRepositiory: ServicesRepositoryProtocol {
    func getServicesInfo(visiteId: Int) -> Future<ServicesListModel, Error> {
        return ApiManager().apiCall(endPoint: GetServiceInfoEndPoint(visitId: visiteId))
    }
    
    func deleteService(visiteId: Int, serviceId: Int) -> Future<DeleteServiceModel, Error> {
        return ApiManager().apiCall(endPoint: DeleteServiceEndPoint(visitId: visiteId, serviceId: serviceId))
    }
}
