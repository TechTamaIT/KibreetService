//
//  SubmitServiceViewModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import Foundation
import Combine

class SubmitServiceViewModel {
    let result = PassthroughSubject<SubmitServiceModel,Error>()
    let message = CurrentValueSubject<String?, Error>(nil)
    var amount = CurrentValueSubject<String,Never>("")
    var kilometers = CurrentValueSubject<String,Never>("")
    private var subscriptions = Set<AnyCancellable>()
    
    func submitServiceRequest(visiteId: Int, availabilityId: Int, attachments: [Attachment]) {
        LoadingManager().showLoadingDialog()
        SubmitServiceRepository().submitService(visiteId: visiteId, availabilityId: availabilityId, amount: Double(amount.value) ?? 0.0, vehicleKilometers: Double(kilometers.value) ?? 0.0, attachments: attachments).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] visiteData in
            LoadingManager().removeLoadingDialog()
            result.send(visiteData)
        }
        .store(in: &subscriptions)
    }
    
    func updateServiceRquest(id: Int, visiteId: Int, attachments: [Attachment]) {
        LoadingManager().showLoadingDialog()
        SubmitServiceRepository().updateService(id: id, visiteId: visiteId, amount: Double(amount.value) ?? 0.0, vehicleKilometers: Double(kilometers.value) ?? 0.0, attachments: attachments).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] visiteData in
            LoadingManager().removeLoadingDialog()
            result.send(visiteData)
        }
        .store(in: &subscriptions)
    }
}
