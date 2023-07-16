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
    
    func submitFirstTimeScan() {
        
    }
    
}
