//
//  CarInfoRepositoryProtocol.swift
//  kabreet
//
//  Created by Essam Orabi on 10/04/2023.
//

import Foundation
import Combine

protocol CarInfoRepositoryProtocol {
    func getCarsInfoApi(onGoing: Bool) -> Future<[CarFullInfoModel],Error>
}
