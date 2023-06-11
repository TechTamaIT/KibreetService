//
//  SelectServiceViewModel.swift
//  KibreetService
//
//  Created by Essam Orabi on 09/06/2023.
//

import Foundation
import Combine

class SelectServiceViewModel {
    let result = CurrentValueSubject<[ServiceCategoryModel],Error>([ServiceCategoryModel]())
    let message = CurrentValueSubject<String?, Error>(nil)
    private var subscriptions = Set<AnyCancellable>()
    var expandedArray = [Bool]()
    
    func getCategories(visiteId: Int) {
        LoadingManager().showLoadingDialog()
        GetCategoriesReposatory().getCategories(visitId: visiteId).sink { [unowned self] completion in
            switch completion {
            case .failure(let error):
                LoadingManager().removeLoadingDialog()
                message.send(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [unowned self] categories in
            LoadingManager().removeLoadingDialog()
            if categories.isEmpty {
                message.send("No result Found")
            } else {
                self.fillArray(categories: categories)
                result.send(categories)
            }
        }
        .store(in: &subscriptions)

    }
    
    func fillArray(categories: [ServiceCategoryModel]) {
        for _ in categories {
            expandedArray.append(false)
        }
    }
}
