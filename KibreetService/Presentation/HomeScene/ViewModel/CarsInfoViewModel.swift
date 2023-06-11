//
//  DriverInfoViewModel.swift
//  kabreet
//
//  Created by Essam Orabi on 10/04/2023.
//

import Foundation
import Combine

class CarsInfoViewModel {
    let result = CurrentValueSubject<[CarFullInfoModel],Error>([CarFullInfoModel]())
    let message = CurrentValueSubject<String?, Error>(nil)
    private var subscriptions = Set<AnyCancellable>()
    
    
    func getCarsInfo(onGoing: Bool = true) {
        LoadingManager().showLoadingDialog()
        CarInfoRepository().getCarsInfoApi(onGoing: onGoing).sink{ [unowned self] completion in
            switch completion{
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] cars in
            LoadingManager().removeLoadingDialog()
            if cars.isEmpty {
                message.send("No result Found")
            } else {
                result.send(cars)
            }
        }
        .store(in: &subscriptions)
    }
}
