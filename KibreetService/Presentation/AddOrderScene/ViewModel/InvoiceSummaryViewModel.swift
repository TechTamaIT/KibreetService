//
//  InvoiceSummaryViewModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

class InvoiceSummaryViewModel {
    let result = PassthroughSubject<InvoiceSummaryModel,Error>()
    let message = CurrentValueSubject<String?, Error>(nil)
    
    let submitResult = PassthroughSubject<SubmitOrderModel,Error>()
    let submitMessage = CurrentValueSubject<String?, Error>(nil)
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var invoiceNo = ""
    @Published var invoiceDate = ""
    @Published var companyName = ""
    @Published var companyNumber = ""
    @Published var companyAddress = ""
    @Published var serviceSupplierNumber = ""
    @Published var serviceSupplierName = ""
    @Published var serviceSupplierAddress = ""
    @Published var subTotal = ""
    @Published var tax = ""
    @Published var total = ""
    var serviceSummary = [ServiceSummary]()
    
    func getInvoiceSummary(visitedId: Int) {
        LoadingManager().showLoadingDialog()
        InvoiceSummaryRepository().getInvoiceSummary(visiteId: visitedId).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] invoiceData in
            LoadingManager().removeLoadingDialog()
            self.invoiceNo = invoiceData.invoiceNumber
            self.invoiceDate = invoiceData.date.date()
            self.companyName = invoiceData.companyName
            self.companyNumber = "Contact no: ".localized() + invoiceData.companyContactNumber
            self.companyAddress = invoiceData.companyAddress
            self.serviceSupplierName = invoiceData.supplierName
            self.serviceSupplierNumber = "Contact no: ".localized() + invoiceData.supplierContactNumber
            self.serviceSupplierAddress = invoiceData.supplierAddress
            self.subTotal = "\(invoiceData.subtotal) SAR"
            self.tax = "\(invoiceData.tax) SAR"
            self.total = String(format: "%.2f", invoiceData.total) + " SAR"
            self.serviceSummary = invoiceData.services
            result.send(invoiceData)
        }
        .store(in: &subscriptions)
    }
    
    func submitOrder(driverCode: String, visiteId: Int) {
        LoadingManager().showLoadingDialog()
        InvoiceSummaryRepository().submitOrder(driverCode: Int(driverCode) ?? 0, visitedId: visiteId).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                submitMessage.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] returnMessage in
            LoadingManager().removeLoadingDialog()
            submitResult.send(returnMessage)
        }
        .store(in: &subscriptions)
    }
    
    func getServicesCount() -> Int{
        return serviceSummary.count
    }
    
    func getService(index: Int) -> ServiceSummary {
        return serviceSummary[index]
    }
}
