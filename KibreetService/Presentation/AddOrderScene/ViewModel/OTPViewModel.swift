//
//  OTPViewModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 14/06/2023.
//

import Foundation
import Combine

class OTPViewModel {
    let result = PassthroughSubject<ScanCarModel,Error>()
    let message = CurrentValueSubject<String?, Error>(nil)
    var OTP = CurrentValueSubject<String,Never>("")
    private var subscriptions = Set<AnyCancellable>()
    
    func uploadScannedCarInfo(vehicleNfc: String) {
        LoadingManager().showLoadingDialog()
        ScanCarRepository().uploadScanningCarInfo(driverCode: Int(OTP.value) ?? 0, vehicleNfc: vehicleNfc).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] uploadInfo in
            LoadingManager().removeLoadingDialog()
            result.send(uploadInfo)
        }
        .store(in: &subscriptions)
    }
}
