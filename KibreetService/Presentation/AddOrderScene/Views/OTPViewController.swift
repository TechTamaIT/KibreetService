//
//  OTPViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 03/06/2023.
//

import UIKit
import AEOTPTextField

class OTPViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var otpTF: AEOTPTextField!
    @IBOutlet weak var submitButton: UIButton!
    var otpText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
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
    
    @IBAction func submitButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension OTPViewController: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        if code.count >= 4 {
            otpText = code
            self.dismiss(animated: true)
        }
    }
}

