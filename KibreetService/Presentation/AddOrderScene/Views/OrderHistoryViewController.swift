//
//  OrderHistoryViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import UIKit
import Combine

class OrderHistoryViewController: UIViewController {

    @IBOutlet weak var servicesTableView: ContentSizedTableView!
    @IBOutlet weak var vehicleInfoView: CardView!
    @IBOutlet weak var servicesView: UIView!
    @IBOutlet weak var carInfoArrow: UIImageView!
    @IBOutlet weak var servicesArrow: UIImageView!
    @IBOutlet weak var invoiceArrow: UIImageView!
    @IBOutlet weak var invoiceView: UIView!
    @IBOutlet weak var invoicesTableView: ContentSizedTableView!
    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var invoiceDateLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyNumberLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var serviceSupplierNameLabel: UILabel!
    @IBOutlet weak var serviceSupplierAddressLabel: UILabel!
    @IBOutlet weak var serviceSupplierNumberLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var carPlateLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var vehicleModelLabel: UILabel!
    @IBOutlet weak var oilTypeLabel: UILabel!
    @IBOutlet weak var oilViscositytLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    
    var isCardInfoHidden = true
    var isServiceCardHidden = true
    var isInvoiceCardHidden = true
    var visiteId = 0
    private let servicesViewModel = ServicesViewModel()
    private var bindings = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setuptableView()
        bindDataToView()
        bindingViewModelToView()
        servicesViewModel.getServicesInfo(visiteId: visiteId)
    }
    
    func setuptableView() {
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.register(UINib(nibName: ServicesHistoryCell.identifier, bundle: nil), forCellReuseIdentifier: ServicesHistoryCell.identifier)
        
        invoicesTableView.delegate = self
        invoicesTableView.dataSource = self
        invoicesTableView.register(UINib(nibName: InvoiceCell.identifier, bundle: nil), forCellReuseIdentifier: InvoiceCell.identifier)
        
    }
    
    func setupView() {
        vehicleInfoView.isHidden = isCardInfoHidden
        servicesView.isHidden = isServiceCardHidden
        invoiceView.isHidden = isInvoiceCardHidden
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
        
        servicesViewModel.$invoiceNo.sink { [weak self] invoiceNumber in
            self?.invoiceNoLabel.text = invoiceNumber
        }.store(in: &bindings)
        
        servicesViewModel.$invoiceDate.sink { [weak self] invoiceDate in
            self?.invoiceDateLabel.text = invoiceDate
        }.store(in: &bindings)
        
        servicesViewModel.$companyName.sink { [weak self] companyName in
            self?.companyNameLabel.text = companyName
        }.store(in: &bindings)
        
        servicesViewModel.$companyNumber.sink { [weak self] companyNumber in
            self?.companyNumberLabel.text = companyNumber
        }.store(in: &bindings)
        
        servicesViewModel.$companyAddress.sink { [weak self] companyAddress in
            self?.companyAddressLabel.text = companyAddress
        }.store(in: &bindings)
        
        servicesViewModel.$serviceSupplierName.sink { [weak self] serviceSupplierName in
            self?.serviceSupplierNameLabel.text = serviceSupplierName
        }.store(in: &bindings)
        
        servicesViewModel.$serviceSupplierNumber.sink { [weak self] serviceSupplierNumber in
            self?.serviceSupplierNumberLabel.text = serviceSupplierNumber
        }.store(in: &bindings)
        
        servicesViewModel.$serviceSupplierAddress.sink { [weak self] serviceSupplierAddress in
            self?.serviceSupplierAddressLabel.text = serviceSupplierAddress
        }.store(in: &bindings)
        
        servicesViewModel.$subTotal.sink { [weak self] subTotal in
            self?.subTotalLabel.text = subTotal
        }.store(in: &bindings)
        
        servicesViewModel.$tax.sink { [weak self] tax in
            self?.taxLabel.text = tax
        }.store(in: &bindings)
        
        servicesViewModel.$total.sink { [weak self] total in
            self?.totalLabel.text = total
        }.store(in: &bindings)
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
    }
    
    func updateUI() {
        servicesTableView.reloadData()
        invoicesTableView.reloadData()
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func vehiclesInfoButtonDidPressed(_ sender: UIButton) {
        isCardInfoHidden = !isCardInfoHidden
        vehicleInfoView.isHidden = isCardInfoHidden
        carInfoArrow.image = UIImage(named: isCardInfoHidden ? "downArrow" : "upArrow")
    }
    
    @IBAction func servicesButtonDidPressed(_ sender: UIButton) {
        isServiceCardHidden = !isServiceCardHidden
        servicesView.isHidden = isServiceCardHidden
        servicesArrow.image = UIImage(named: isServiceCardHidden ? "downArrow" : "upArrow")
    }
    
    @IBAction func InvoiceButtonDidPressed(_ sender: UIButton) {
        isInvoiceCardHidden = !isInvoiceCardHidden
        invoiceView.isHidden = isInvoiceCardHidden
        invoiceArrow.image = UIImage(named: isInvoiceCardHidden ? "downArrow" : "upArrow")
    }
    
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1001 {
            return servicesViewModel.getServicesCount()
        } else {
            return servicesViewModel.getInvoiceServiceCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1001 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesHistoryCell.identifier, for: indexPath) as? ServicesHistoryCell else {return UITableViewCell()}
            cell.configureCell(data: servicesViewModel.getService(index: indexPath.row))
            return cell
        } else  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceCell.identifier, for: indexPath) as? InvoiceCell else { return UITableViewCell() }
            cell.configureInoviceCell(data: servicesViewModel.getInvoiceService(index: indexPath.row))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.tag == 1002 {
            let header = InvoiceHeaderView()
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 1002 {
            return  36
        } else {
            return 0
        }
    }
}
