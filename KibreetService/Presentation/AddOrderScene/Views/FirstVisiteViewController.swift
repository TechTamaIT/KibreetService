//
//  FirstVisiteViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 12/07/2023.
//

import UIKit

class FirstVisiteViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var vehicleTypeTF: UITextField!
    @IBOutlet weak var platNumberTF: UITextField!
    
    
    @IBOutlet weak var driverCodeTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func submitButtonDidPressed(_ sender: UIButton) {
    }
}
