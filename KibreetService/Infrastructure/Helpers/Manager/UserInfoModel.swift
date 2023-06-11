//
//  UserInfoManager.swift
//  SFC
//
//  Created by Ahmed Labeeb on 01/08/2022.
//

import Foundation
import Combine

class UserInfoManager {
    
    static let shared = UserInfoManager()
    let defaults = UserDefaults.standard
    @Published var user: UserModel?
    
    init() {
        getUser()
    }
    
    func saveUser(token: String, refreshToken: String) {
        defaults.set(token, forKey: UserConstant.userToken)
        defaults.set(refreshToken, forKey: UserConstant.refreshToken)
        getUser()
    }
    
    func logout() {
        defaults.removeObject(forKey: UserConstant.userToken)
        defaults.removeObject(forKey: UserConstant.refreshToken)
        getUser()
    }
    
    func getUser() {
        if let token = defaults.value(forKey: UserConstant.userToken) as? String,
           let refreshToken = defaults.value(forKey: UserConstant.refreshToken) as? String{
            user = UserModel.init(token: token, refreshToken: refreshToken)
        }else {
            user = nil
        }
    }
    
    var isLoggedIn: Bool {
        if (defaults.value(forKey: UserConstant.userToken) as? String) != nil{
            return true
        }else {
            return false
        }
    }
    
    func setIsOnboardingPassed(_ isPassed:Bool){
        defaults.set(isPassed, forKey: UserConstant.isOnboardingPassed)
    }

    func getIsOnboardingPassed()->Bool{
        if (defaults.object(forKey: UserConstant.isOnboardingPassed) != nil) {
            return defaults.bool(forKey: UserConstant.isOnboardingPassed)
        }else{
            return false
        }
    }
    
    func setIsFirstTime(_ isFirst:Bool){
        defaults.set(isFirst, forKey: UserConstant.isFirstTime)
    }

    func getIsFirstTime()->Bool{
        if (defaults.object(forKey: UserConstant.isOnboardingPassed) != nil) {
            return defaults.bool(forKey: UserConstant.isFirstTime)
        }else{
            return false
        }
    }

}

struct UserModel {
    let token: String
    let refreshToken: String
}
