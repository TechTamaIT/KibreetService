//
//  ServicesViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit
import Combine

class ServicesViewController: UIViewController {

    @IBOutlet weak var carPlateLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var oilTypeLabel: UILabel!
    @IBOutlet weak var oilViscositytLabel: UILabel!
    @IBOutlet weak var oilBrandNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var expandViewButton: UIButton!
    @IBOutlet weak var cardInfoView: CardView!
    @IBOutlet weak var servicesTableview: ContentSizedTableView!
    @IBOutlet weak var addServiceButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var visiteId = 0
    var isCardInfoHidden = true
    private let servicesViewModel = ServicesViewModel()
    private var bindings = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        bindingViewModelToView()
        bindDataToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        servicesViewModel.getServicesInfo(visiteId: visiteId)
    }
    
    func setupTableView() {
        servicesTableview.delegate = self
        servicesTableview.dataSource = self
        servicesTableview.register(UINib(nibName: ServiceCell.identifier, bundle: nil), forCellReuseIdentifier: ServiceCell.identifier)
    }
    
    func setupView() {
        cardInfoView.isHidden = isCardInfoHidden
        addServiceButton.setTitle("", for: .normal)
        nextButton.layer.cornerRadius = 10
    }
    
    func bindDataToView() {
        servicesViewModel.$carPlate.sink { [weak self] carPlate in
            self?.carPlateLabel.text = carPlate
        }.store(in: &bindings)
        
        servicesViewModel.$vehicleType.sink { [weak self] vehicleType in
            self?.vehicleTypeLabel.text = vehicleType
        }.store(in: &bindings)
        
        servicesViewModel.$vehicleModel.sink { [weak self] vehicleModel in
            self?.vehicleModelLabel.text = vehicleModel
        }.store(in: &bindings)
        
        servicesViewModel.$oilType.sink { [weak self] oilType in
            self?.oilTypeLabel.text = oilType
        }.store(in: &bindings)
        
        servicesViewModel.$oilViscosity.sink { [weak self] viscosity in
            self?.oilViscositytLabel.text = viscosity
        }.store(in: &bindings)
        
        servicesViewModel.$branchName.sink { [weak self] branch in
            self?.brandNameLabel.text = branch
        }.store(in: &bindings)
        
        servicesViewModel.$rowCount.map{ rowCount -> UIColor in
            if rowCount > 0 {
                return UIColor.hexColor(string: "#C02C4A")
            } else {
                return UIColor.hexColor(string: "#C9CDD2")
            }
        }
        .assign(to: \.backgroundColor, on: nextButton)
        .store(in: &bindings)
        
        
        servicesViewModel.$rowCount.map{ rowCount -> Bool in
            return rowCount > 0
        }
        .assign(to: \.isEnabled, on: nextButton)
        .store(in: &bindings)
    }
    
    func bindingViewModelToView(){
        servicesViewModel.result.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.updateUI()
        }).store(in: &bindings)
        
        servicesViewModel.message.sink(receiveCompletion: {completion in
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
        
        
        
        servicesViewModel.deleteResult.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            self.deleteServiceHandler()
        }).store(in: &bindings)
        
        servicesViewModel.deleteMessage.sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: error.localizedDescription, buttonTitle: "Ok".localized())
            case .finished:
                print("SUCCESS ")
            }
        }, receiveValue: {[unowned self] value in
            if value == "success"{
                self.deleteServiceHandler()
            }else{
                if value != nil {
                    self.showLocalizedAlert(style: .alert, title: "Error".localized(), message: value!, buttonTitle: "Ok".localized())
                }
            }
        }).store(in: &bindings)
    }
    
    func updateUI() {
        servicesTableview.reloadData()
    }
    
    func deleteServiceHandler() {
        servicesViewModel.getServicesInfo(visiteId: visiteId)
    }
    
    func deleteServiceAlert(serviceId: Int) {
        let deleteAlert = UIAlertController(title: "Warning".localized(), message: "Do you want to delete this service".localized(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: .default) { _ in
            self.servicesViewModel.deleteService(visiteId: self.visiteId, serviceId: serviceId)
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        deleteAlert.addAction(okAction)
        deleteAlert.addAction(cancelAction)
        self.present(deleteAlert, animated: true)
    }
    
    func updateService(service: Service) {
        let updateService = UploadServiceViewController.instantiate(fromAppStoryboard: .AddOrder)
        updateService.isUpdated = true
        updateService.service = service
        updateService.modalPresentationStyle = .fullScreen
        self.present(updateService, animated: true)
    }

    @IBAction func expandViewButtonPressed(_ sender: UIButton) {
        isCardInfoHidden = !isCardInfoHidden
        cardInfoView.isHidden = isCardInfoHidden
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addServiceButtonPressed(_ sender: UIButton) {
        let addServiceVC = SelectServiceVC.instantiate(fromAppStoryboard: .AddOrder)
        addServiceVC.modalPresentationStyle = .fullScreen
        addServiceVC.visiId = self.visiteId
        self.present(addServiceVC, animated: true)
    }
    
    @IBAction func nextButtonDidPressed(_ sender: UIButton) {
        let invoiceVC = InvoiceViewController.instantiate(fromAppStoryboard: .AddOrder)
        invoiceVC.visiteId = visiteId
        invoiceVC.modalPresentationStyle = .fullScreen
        self.present(invoiceVC, animated: true)
    }
}

extension ServicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesViewModel.getServicesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.identifier, for: indexPath) as? ServiceCell else { return UITableViewCell() }
        cell.configureCell(data: servicesViewModel.getService(index: indexPath.row))
        
        cell.deleteTapped = {[weak self] serviceId in
            self?.deleteServiceAlert(serviceId: serviceId)
        }
        
        cell.editTapped = {[weak self] service in
            self?.updateService(service: service)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

