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
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var carPlate: String = ""
    @Published var vehicleType: String = ""
    @Published var vehicleModel: String = ""
    @Published var oilType: String = ""
    @Published var oilViscosity: String = ""
    @Published var branchName: String = ""
    @Published var rowCount: Int = 0
    var services = [Service]()
    
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
            
            result.send(visiteData)
        }
        .store(in: &subscriptions)
    }
    
    
    func getServicesCount() -> Int {
        return services.count
    }
    
    func getService(index: Int) -> Service {
        return services[index]
    }
}

