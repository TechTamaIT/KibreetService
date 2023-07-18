//
//  FirstVisiteViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 12/07/2023.
//

import UIKit
import Combine
import iOSDropDown
import CoreNFC

class FirstVisiteViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var vehicleTypeTF: DropDown!
    @IBOutlet weak var platNumberTF: UITextField!
    @IBOutlet weak var driverCodeTF: UITextField!
    @IBOutlet weak var successfulView: CardView!
    
    private let firstTimeViewModel = FirstTimeViewModel()
    private var bindings = Set<AnyCancellable>()
    var selectedVehicleType = 0
    var session: NFCNDEFReaderSession?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewToLoginViewModel()
        bindingViewModelToView()
        firstTimeViewModel.getVehicleTypes()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        successfulView.isHidden = true
        closeButton.setTitle("", for: .normal)
    }
    
    func bindViewToLoginViewModel(){
        driverCodeTF.textPublisher.sink(receiveValue: { [unowned self] text in
            firstTimeViewModel.driverCode.send(text)
        }).store(in: &bindings)
        platNumberTF.textPublisher.sink(receiveValue: { [unowned self] text in
            firstTimeViewModel.plateNumber.send(text)
        }).store(in: &bindings)
    }
    
    func bindingViewModelToView(){
        firstTimeViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.updateDropDown()
        }).store(in: &bindings)
        
        firstTimeViewModel.message.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            if value == "success"{
                self.updateDropDown()
            }else{
                if value != nil {
                    self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value!, buttonTitle: "Ok".localized())
                }
            }
        }).store(in: &bindings)
        
        
        
        firstTimeViewModel.result2.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.updateSubmitButton()
        }).store(in: &bindings)
        
        firstTimeViewModel.message2.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            if value == "success"{
                self.updateSubmitButton()
            }else{
                if value != nil {
                    self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value!, buttonTitle: "Ok".localized())
                }
            }
        }).store(in: &bindings)
    }
    
    func updateDropDown() {
        var dropDownSource = [String]()
        var dropDownOptionIds = [Int]()
        for item in firstTimeViewModel.result.value {
            dropDownSource.append(item.vehicleTypeNameEn)
            dropDownOptionIds.append(item.vehicleType)
        }
        
        vehicleTypeTF.optionArray = dropDownSource
        //Its Id Values and its optional
        vehicleTypeTF.optionIds = dropDownOptionIds

        // The the Closure returns Selected Index and String
        vehicleTypeTF.didSelect{(selectedText , index ,id) in
            self.selectedVehicleType = id
        }
        
    }
    
    func updateSubmitButton() {
        successfulView.isHidden = false
        submitButton.setTitle("Write Info to NFC".localized(), for: .normal)
        platNumberTF.isEnabled = false
        vehicleTypeTF.isEnabled = false
        driverCodeTF.isEnabled = false
    }
    
    func writeToNFC() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your IPhone near NFC tag to write the code".localized()
        session?.begin()
    }
    
    
    @IBAction func closeButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func submitButtonDidPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Submit".localized() {
            if platNumberTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && driverCodeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && vehicleTypeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                firstTimeViewModel.submitFirstTimeScan(vehicleType: selectedVehicleType)
            } else {
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: "Please fill all information to continue".localized(), buttonTitle: "Ok".localized())
            }
        } else {
            writeToNFC()
        }
    }
}

extension FirstVisiteViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead) && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: "Session Invalidate".localized(), buttonTitle: "Ok".localized())
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let str: String = firstTimeViewModel.NFCEncriptedData
        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than one tag presented. please remove them and try again".localized()
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }
        let tag = tags.first!
        session.connect(to: tag) { error in
            if error != nil {
                session.alertMessage = "Unable to connect to tag".localized()
                session.invalidate()
                return
            }
            tag.queryNDEFStatus { status, capacity, error in
                if error != nil {
                    session.alertMessage = "Unable to connect to tag".localized()
                    session.invalidate()
                    return
                }
                switch status {
                case .notSupported:
                    session.alertMessage = "NFC tag not supported".localized()
                    session.invalidate()
                case .readOnly:
                    session.alertMessage = "NFC tag is locked".localized()
                    session.invalidate()
                case .readWrite:
                    tag.writeNDEF(.init(records: [NFCNDEFPayload.wellKnownTypeURIPayload(string: str)!])) { error in
                        if error != nil {
                            session.alertMessage = "write code failed".localized()
                        } else {
                            session.alertMessage = "Nice, Tag has been activated".localized()
                        }
                        session.invalidate()
                    }
                @unknown default:
                    session.alertMessage = "unknown error occured".localized()
                    session.invalidate()
                }
            }
        }
    }
}
