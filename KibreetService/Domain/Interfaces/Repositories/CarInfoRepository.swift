//
//  CarInfoRepository.swift
//  kabreet
//
//  Created by Essam Orabi on 10/04/2023.
//

import Foundation
import Combine

struct CarInfoRepository: CarInfoRepositoryProtocol {
    func getCarsInfoApi(onGoing: Bool) -> Future<[CarFullInfoModel], Error> {
        return ApiManager().apiCall(endPoint: CarInfoEndPoint(onGoing: onGoing))
    }
}
