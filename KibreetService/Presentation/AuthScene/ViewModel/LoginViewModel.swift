//
//  LoginViewModel.swift
//  kabreet
//
//  Created by Essam Orabi on 31/03/2023.
//

import Foundation
import Combine

class LoginViewModel {
    var email = CurrentValueSubject<String,Never>("")
    var password = CurrentValueSubject<String,Never>("")
    let result = PassthroughSubject<String,Error>()
    private var subscriptions = Set<AnyCancellable>()
    
    func login() {
        let message = validate()
        if message != nil {
            result.send(message ?? "")
        } else {
            LoadingManager().showLoadingDialog()
            AuthRepository().loginApi(email: email.value, password: password.value, accountType: 5).sink{ [unowned self] completion in
                switch completion{
                case .failure(let error):
                    LoadingManager().removeLoadingDialog()
                    result.send(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [unowned self] user in
                LoadingManager().removeLoadingDialog()
                if let token = user.accessToken , let refreshToken = user.refreshToken {
                    UserInfoManager.shared.saveUser(token: token, refreshToken: refreshToken)
                    result.send("success")
                } else {
                    let message = user.message
                    result.send(message ?? "")
                }
            }
            .store(in: &subscriptions)
        }
    }
    
    private func validate() -> String? {
        if !(email.value.isValidEmail()) {
            return "Please enter valid email Address".localized()
        } else if password.value == "" {
            return "Please enter valid Password".localized()
        } else {
            return nil
        }
    }
}


extension String {
func isValidEmail() -> Bool {
    // here, `try!` will always succeed because the pattern is valid
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
   }
}
