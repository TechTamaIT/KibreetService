//
//  ScanCarViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 03/06/2023.
//

import UIKit

class ScanCarViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var scanTitleLabel: UILabel!
    @IBOutlet weak var scanDescriptionLabel: UILabel!
    @IBOutlet weak var scanImageView: UIImageView!
    
    @IBOutlet weak var scanButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.25)
        mainView.roundViewCorners([.topLeft, .topRight], radius: 10)
        scanButton.layer.cornerRadius = 10
    }
    
    @IBAction func scanButtonDidPressed(_ sender: UIButton) {
        let otpVc = OTPViewController.instantiate(fromAppStoryboard: .AddOrder)
        otpVc.modalPresentationStyle = .overFullScreen
        self.present(otpVc, animated: true)
//        self.dismiss(animated: true)
    }
}
