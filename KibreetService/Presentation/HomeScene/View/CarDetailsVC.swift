//
//  CarDetailsVC.swift
//  kabreet
//
//  Created by Essam Orabi on 06/03/2023.
//

import UIKit
import Combine
import CoreNFC

class CarDetailsVC: UIViewController {

    @IBOutlet weak var carInfoTableView: UITableView!
    @IBOutlet weak var noCarsView: UIView!
    private let carsInfoViewModel = CarsInfoViewModel()
    let refreshControl = UIRefreshControl()
    private var bindings = Set<AnyCancellable>()
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindingViewModelToView()
        carsInfoViewModel.getCarsInfo()
    }
    
    func startSession() {
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your phone near the NFC Tag"
        session?.begin()
    }
    
    func setupTableView() {
        carInfoTableView.delegate = self
        carInfoTableView.dataSource = self
        carInfoTableView.register(UINib(nibName: VehiclesCell.identifier, bundle: nil), forCellReuseIdentifier: VehiclesCell.identifier)
        carInfoTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(scanCompeleted), name: NSNotification.Name(rawValue: "scanComplete"), object: nil)
    }
    
    @objc func refreshTableView(_ sender: UIRefreshControl) {
        carsInfoViewModel.getCarsInfo()
    }
    
    @objc func scanCompeleted() {
        carsInfoViewModel.getCarsInfo()
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        //startSession()
        
        let firstScanVC = FirstVisiteViewController.instantiate(fromAppStoryboard: .AddOrder)
        self.present(firstScanVC, animated: true)
    }
    
    
    func bindingViewModelToView(){
        carsInfoViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.updateUI()
        }).store(in: &bindings)
        
        carsInfoViewModel.message.sink(receiveCompletion: {completion in
            switch completion {
                case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
                case .finished:
                        print("SUCCESS ")
                }
            }, receiveValue: {[unowned self] value in
                if value == "success"{
                    self.updateUI()
                }else{
                    if value != nil {
                        self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value!, buttonTitle: "Ok".localized())
                    }
                }
            }).store(in: &bindings)
    }


    func updateUI() {
        refreshControl.endRefreshing()
        carInfoTableView.reloadData()
        if carsInfoViewModel.result.value.count <= 0 {
            noCarsView.isHidden = false
        } else {
            noCarsView.isHidden = true
        }
    }
}

extension CarDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsInfoViewModel.result.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehiclesCell.identifier, for: indexPath) as? VehiclesCell else { return UITableViewCell() }
        let car = carsInfoViewModel.result.value[indexPath.row]
        cell.configureCell(imageName: "grayCheck", data: car)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let serviceVC = ServicesViewController.instantiate(fromAppStoryboard: .AddOrder)
        serviceVC.modalPresentationStyle = .fullScreen
        serviceVC.visiteId = carsInfoViewModel.result.value[indexPath.row].visitId
        self.present(serviceVC, animated: true)
    }
}


extension CarDetailsVC: NFCNDEFReaderSessionDelegate {
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("session activated")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)!
        }
        
        print(result)
        session.alertMessage = "Tag scan successfully"
        session.invalidate()
        let otpVc = OTPViewController.instantiate(fromAppStoryboard: .AddOrder)
        otpVc.modalPresentationStyle = .overFullScreen
        otpVc.scannedText = result
        self.present(otpVc, animated: true)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
}
