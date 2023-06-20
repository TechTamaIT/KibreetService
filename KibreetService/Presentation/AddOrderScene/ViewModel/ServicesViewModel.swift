//
//  ServicesViewModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

class ServicesViewModel {
    let result = PassthroughSubject<ServicesListModel,Error>()
    let message = CurrentValueSubject<String?, Error>(nil)
    
    let deleteResult = PassthroughSubject<DeleteServiceModel,Error>()
    let deleteMessage = CurrentValueSubject<String?, Error>(nil)
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var carPlate: String = ""
    @Published var vehicleType: String = ""
    @Published var vehicleModel: String = ""
    @Published var oilType: String = ""
    @Published var oilViscosity: String = ""
    @Published var branchName: String = ""
    @Published var rowCount: Int = 0
    
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
    
    var services = [Service]()
    var invoiceServices = [InvoiceDetailsService]()
    
    func getServicesInfo(visiteId: Int) {
        LoadingManager().showLoadingDialog()
        ServicesInfoRepositiory().getServicesInfo(visiteId: visiteId).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] visiteData in
            LoadingManager().removeLoadingDialog()
            self.carPlate = visiteData.vehicle.plateNumber
            self.vehicleType = visiteData.vehicle.vehicleTypeName
            self.vehicleModel = visiteData.vehicle.vehicleModel
            self.oilType = visiteData.vehicle.oilBrand
            self.oilViscosity = visiteData.vehicle.oilViscosity
            self.branchName = visiteData.vehicle.branchName
            self.rowCount = visiteData.services.count
            self.services = visiteData.services
            
            if let invoice = visiteData.invoiceDetails {
                self.invoiceNo = invoice.invoiceNumber
                self.invoiceDate = invoice.date.date()
                self.companyName = invoice.companyName
                self.companyNumber = "Contact no: ".localized() + invoice.companyContactNumber
                self.companyAddress = invoice.companyAddress
                self.serviceSupplierName = invoice.supplierName
                self.serviceSupplierNumber = "Contact no: ".localized() + invoice.supplierContactNumber
                self.serviceSupplierAddress = invoice.supplierAddress
                self.subTotal = "\(invoice.subtotal) SAR"
                self.tax = "\(invoice.tax) SAR"
                self.total = String(format: "%.2f", invoice.total) + " SAR"
                self.invoiceServices = invoice.services
            }
            
            result.send(visiteData)
        }
        .store(in: &subscriptions)
    }
    
    func deleteService(visiteId: Int, serviceId: Int) {
        LoadingManager().showLoadingDialog()
        ServicesInfoRepositiory().deleteService(visiteId: visiteId, serviceId: serviceId).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                deleteMessage.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] deleteMessage in
            LoadingManager().removeLoadingDialog()
            deleteResult.send(deleteMessage)
        }
        .store(in: &subscriptions)
    }
    
    func getServicesCount() -> Int {
        return services.count
    }
    
    func getService(index: Int) -> Service {
        return services[index]
    }
    
    func getInvoiceServiceCount() -> Int{
        return invoiceServices.count
    }
    
    func getInvoiceService(index: Int) -> InvoiceDetailsService {
        return invoiceServices[index]
    }
}

