//
//  ServiceCenterCategoriesProtocol.swift
//  KibreetService
//
//  Created by Essam Orabi on 09/06/2023.
//

import Foundation
import Combine

protocol ServiceCenterCategoriesProtocol {
    func getCategories(visitId: Int) -> Future<[ServiceCategoryModel],Error>
}
