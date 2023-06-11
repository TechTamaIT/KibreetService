//
//  InvoiceSummaryRepositoryProtocol.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine


protocol InvoiceSummaryRepositoryProtocol {
    func getInvoiceSummary(visiteId: Int) -> Future<InvoiceSummaryModel, Error>
}
