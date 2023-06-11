//
//  ForgetPasswordVC.swift
//  kabreet
//
//  Created by Essam Orabi on 15/04/2023.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        submitButton.layer.cornerRadius = 10
        backButton.setTitle("", for: .normal)
    }

    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitButtonDidPressed(_ sender: UIButton) {
        
    }
}
