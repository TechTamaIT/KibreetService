//
//  ChangePasswordViewModel.swift
//  kabreet
//
//  Created by Essam Orabi on 16/04/2023.
//

import Foundation
import Combine

class ChangePasswordViewModel {
    var currentPassword = CurrentValueSubject<String,Never>("")
    var newPassword = CurrentValueSubject<String,Never>("")
    var confirmPassword = CurrentValueSubject<String,Never>("")
    let result = PassthroughSubject<String,Error>()
    let message = CurrentValueSubject<String?, Error>(nil)
    private var subscriptions = Set<AnyCancellable>()
    
    func changePassword() {
        let localmessage = validate()
        if localmessage != nil {
            message.send(localmessage ?? "")
        } else {
            LoadingManager().showLoadingDialog()
            ChangePasswordRepository().changePassword(currentPassword: currentPassword.value, newPassword: newPassword.value).sink{ [unowned self] completion in
                switch completion{
                case .failure(let error):
                    LoadingManager().removeLoadingDialog()
                    message.send(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [unowned self] info in
                LoadingManager().removeLoadingDialog()
                result.send(info.message)
            }
            .store(in: &subscriptions)
            
        }
        
    }
    
    
    private func validate() -> String? {
        if currentPassword.value.trimmingCharacters(in: Foundation.CharacterSet.whitespacesAndNewlines) == "" || newPassword.value.trimmingCharacters(in: Foundation.CharacterSet.whitespacesAndNewlines) == "" {
            return "please Enter Current and new password to continue".localized()
        }
        
        if currentPassword.value.trimmingCharacters(in: Foundation.CharacterSet.whitespacesAndNewlines) != confirmPassword.value.trimmingCharacters(in: Foundation.CharacterSet.whitespacesAndNewlines)  {
            return "mismatched passwords".localized()
        }
        
        return nil
        
        
    }
}
