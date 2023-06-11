//
//  LoginVC.swift
//  kabreet
//
//  Created by Essam Orabi on 04/03/2023.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    
    @IBOutlet weak var useNameTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    
    private let loginViewModel = LoginViewModel()
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewToLoginViewModel()
        bindingViewModelToView()
    }
    
    func bindViewToLoginViewModel(){
        useNameTF.textPublisher.sink(receiveValue: { [unowned self] text in
            loginViewModel.email.send(text)
        }).store(in: &bindings)
        passwordTF.textPublisher.sink(receiveValue: { [unowned self] text in
            loginViewModel.password.send(text)
        }).store(in: &bindings)
    }
    
    func bindingViewModelToView(){
        loginViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            if value == "success"{
                goToHomeScreen()
            }else{
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value, buttonTitle: "Ok".localized())
            }
        }).store(in: &bindings)
    }
    
    func setupUI() {
        loginButton.layer.cornerRadius = 10
    }
    
    func goToHomeScreen() {
        guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController else {return}
        UIApplication.shared.windows.first?.rootViewController = homeVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loginViewModel.login()
    }
}
