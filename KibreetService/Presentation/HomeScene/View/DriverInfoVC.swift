//
//  DriverInfoVC.swift
//  kabreet
//
//  Created by Essam Orabi on 14/03/2023.
//

import UIKit

class DriverInfoVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDriverInfo()
    }
    
    func setupUI() {
        saveChangesButton.layer.cornerRadius = 10
        backButton.setTitle("", for: .normal)
    }
    
    func getDriverInfo() {
        guard let driver = UserInfoManager.shared.user else { return }
        let data = decode(jwtToken: driver.token)
        let email = data["email"] as? String
        let phone = data["phone"] as? String
        userNameTF.text = email
        phoneNumberTF.text = phone
        passwordTF.text = "00000000"
        userNameTF.isEnabled = false
        phoneNumberTF.isEnabled = false
        passwordTF.isEnabled = false
    }

    @IBAction func saveChangesButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func changePasswordButtonDidPRessed(_ sender: UIButton) {
        let changePassVC = ChangePasswordVC.instantiate(fromAppStoryboard: .Home)
        changePassVC.modalPresentationStyle = .fullScreen
        self.present(changePassVC, animated: true)
    }
}
