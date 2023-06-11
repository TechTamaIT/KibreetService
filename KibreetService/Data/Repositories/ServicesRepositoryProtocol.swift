//
//  ServicesRepositoryProtocol.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

protocol ServicesRepositoryProtocol {
    func getServicesInfo(visiteId: Int) -> Future<ServicesListModel, Error>
}
