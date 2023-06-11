//
//  InvoiceSummaryRepository.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

struct InvoiceSummaryRepository: InvoiceSummaryRepositoryProtocol {
    func getInvoiceSummary(visiteId: Int) -> Future<InvoiceSummaryModel, Error> {
        return ApiManager().apiCall(endPoint: InvoiceSummaryEndPoint(visitId: visiteId))
    }
}
