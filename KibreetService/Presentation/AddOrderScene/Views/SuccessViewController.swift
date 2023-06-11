//
//  SuccessViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()

        // Do any additional setup after loading the view.
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        timer?.invalidate()
        timer = nil
        self.dismiss(animated: true)
    }

}
