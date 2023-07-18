//
//  FirstTimeViewModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 17/07/2023.
//

import Foundation
import Combine


class FirstTimeViewModel {
    let result = CurrentValueSubject<[VehiclesTypeModel],Error>([VehiclesTypeModel]())
    let message = CurrentValueSubject<String?, Error>(nil)
    
    let result2 = PassthroughSubject<FirstScanResponse,Error>()
    let message2 = CurrentValueSubject<String?, Error>(nil)
    
    var driverCode = CurrentValueSubject<String,Never>("")
    var plateNumber = CurrentValueSubject<String,Never>("")
    var NFCEncriptedData = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    func getVehicleTypes() {
        LoadingManager().showLoadingDialog()
        FirstTimeRepository().getVehcileTypes().sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] vehcileTypes in
            LoadingManager().removeLoadingDialog()
            result.send(vehcileTypes)
        }
        .store(in: &subscriptions)
    }
    
    func submitFirstTimeScan(vehicleType: Int) {
        LoadingManager().showLoadingDialog()
        FirstTimeRepository().submitFirstTimeScan(carPlateNo: plateNumber.value, vehicleType: vehicleType, driverCode: Int(driverCode.value) ?? 0).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message2.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] encripteNFC in
            LoadingManager().removeLoadingDialog()
            self.NFCEncriptedData = encripteNFC.encryptedNfc
            result2.send(encripteNFC)
        }
        .store(in: &subscriptions)
    }
    
}
