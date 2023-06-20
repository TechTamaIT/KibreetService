//
//  OTPViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 03/06/2023.
//

import UIKit
import AEOTPTextField
import Combine

class OTPViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var otpTF: AEOTPTextField!
    @IBOutlet weak var submitButton: UIButton!
    private let oTPViewModel = OTPViewModel()
    private var bindings = Set<AnyCancellable>()
    var scannedText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewToSubmitViewModel()
        bindingViewModelToView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        submitButton.isEnabled = false
        otpTF.otpDelegate = self
        otpTF.otpFontSize = 16
        otpTF.otpTextColor = .black
        otpTF.otpFilledBorderWidth = 1
        otpTF.configure(with: 4)
        submitButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.hexColor(string: "#C02C4A").cgColor
        self.view.backgroundColor = .black.withAlphaComponent(0.25)
    }
    
    func bindViewToSubmitViewModel(){
        otpTF.textPublisher.sink(receiveValue: { [unowned self] text in
            oTPViewModel.OTP.send(text)
        }).store(in: &bindings)
        
        
    }
    
    func bindingViewModelToView(){
        oTPViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.finishSubmitting(message: value.message)
        }).store(in: &bindings)
        
        oTPViewModel.message.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            if value != nil {
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value!, buttonTitle: "Ok".localized())
            }
        }).store(in: &bindings)
    }
    
    func finishSubmitting(message: String) {
        let alert = UIAlertController(title: "Error".localized(), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: .default) { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scanComplete"), object: nil)
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func submitButtonDidPressed(_ sender: UIButton) {
        oTPViewModel.uploadScannedCarInfo(vehicleNfc: scannedText)
    }
    
    @IBAction func cancelButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension OTPViewController: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        if code.count >= 4 {
            submitButton.isEnabled = true
            UserInfoManager.shared.setDriverCode(code)
        }
    }
}

