//
//  ScanCarViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 03/06/2023.
//

import UIKit
import CoreNFC

class ScanCarViewController: UIViewController {

    
    var session: NFCNDEFReaderSession?
    var timer: Timer?
    var NFCCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        startSession()
    }
    
    func startSession() {
        
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your phone near the NFC Tag"
        session?.begin()
    }
    
    @objc func timerAction() {
        timer?.invalidate()
        timer = nil
        let otpVc = OTPViewController.instantiate(fromAppStoryboard: .AddOrder)
        otpVc.scannedText = NFCCode
        otpVc.modalPresentationStyle = .overFullScreen
        self.present(otpVc, animated: true)
    }
}


extension ScanCarViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {

    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
}
