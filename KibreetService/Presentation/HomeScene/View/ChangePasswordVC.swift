//
//  ChangePasswordVC.swift
//  kabreet
//
//  Created by Essam Orabi on 14/03/2023.
//

import UIKit
import Combine

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var confirmNewPasswordTF: UITextField!
    
    let changePasswordViewModel = ChangePasswordViewModel()
    private var bindings = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingViewModelToView()
        bindViewToLoginViewModel()
    }
    
    func setupUI() {
        saveChangesButton.layer.cornerRadius = 10
        backButton.setTitle("", for: .normal)
    }
    
    func bindViewToLoginViewModel(){
        currentPasswordTF.textPublisher.sink(receiveValue: { [unowned self] text in
            changePasswordViewModel.currentPassword.send(text)
        }).store(in: &bindings)
        newPasswordTF.textPublisher.sink(receiveValue: { [unowned self] text in
            changePasswordViewModel.newPassword.send(text)
        }).store(in: &bindings)
        
        confirmNewPasswordTF.textPublisher.sink(receiveValue: { [unowned self] text in
            changePasswordViewModel.confirmPassword.send(text)
        }).store(in: &bindings)
    }
    
    func bindingViewModelToView(){
        changePasswordViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            goToLogin(message: value)
        }).store(in: &bindings)
        
        
        changePasswordViewModel.message.sink(receiveCompletion: {completion in
            switch completion {
                case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
                case .finished:
                        print("SUCCESS ")
                }
            }, receiveValue: {[unowned self] value in
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value ?? "", buttonTitle: "Ok".localized())
            }).store(in: &bindings)

    }
    
    func goToLogin(message: String) {
        self.localized(style: .alert, alertTitle: "Warning".localized(), message: message, buttonTitle: "Ok".localized()) {
            UserInfoManager.shared.logout()
            guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveChangesButtonDidPressed(_ sender: UIButton) {
        changePasswordViewModel.changePassword()
    }
}
