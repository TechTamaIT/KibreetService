//
//  GetCategoriesReposatory.swift
//  KibreetService
//
//  Created by Essam Orabi on 09/06/2023.
//

import Foundation
import Combine

struct GetCategoriesReposatory: ServiceCenterCategoriesProtocol {
    func getCategories(visitId: Int) -> Future<[ServiceCategoryModel], Error> {
        return ApiManager().apiCall(endPoint: GetCategoryEndPoint(visitId: visitId))
    }
}
