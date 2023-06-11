//
//  InvoiceViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit
import Combine

class InvoiceViewController: UIViewController {

    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var invoiceDateLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyNumberLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var serviceSupplierNumberLabel: UILabel!
    @IBOutlet weak var serviceSupplierNameLabel: UILabel!
    @IBOutlet weak var serviceSupplierAddressLabel: UILabel!
    @IBOutlet weak var invoicesTableView: ContentSizedTableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    private let invoiceViewModel = InvoiceSummaryViewModel()
    private var bindings = Set<AnyCancellable>()
    var visiteId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        bindDataToView()
        invoiceViewModel.getInvoiceSummary(visitedId: visiteId)

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        invoicesTableView.delegate = self
        invoicesTableView.dataSource = self
        invoicesTableView.register(UINib(nibName: InvoiceCell.identifier, bundle: nil), forCellReuseIdentifier: InvoiceCell.identifier)
    }
    
    func setupView() {
        nextButton.layer.cornerRadius = 10
    }
    
    func bindDataToView() {
        invoiceViewModel.$invoiceNo.sink { [weak self] invoiceNumber in
            self?.invoiceNoLabel.text = invoiceNumber
        }.store(in: &bindings)
        
        invoiceViewModel.$invoiceDate.sink { [weak self] invoiceDate in
            self?.invoiceDateLabel.text = invoiceDate
        }.store(in: &bindings)
        
        invoiceViewModel.$companyName.sink { [weak self] companyName in
            self?.companyNameLabel.text = companyName
        }.store(in: &bindings)
        
        invoiceViewModel.$companyNumber.sink { [weak self] companyNumber in
            self?.companyNumberLabel.text = companyNumber
        }.store(in: &bindings)
        
        invoiceViewModel.$companyAddress.sink { [weak self] companyAddress in
            self?.companyAddressLabel.text = companyAddress
        }.store(in: &bindings)
        
        invoiceViewModel.$serviceSupplierName.sink { [weak self] serviceSupplierName in
            self?.serviceSupplierNameLabel.text = serviceSupplierName
        }.store(in: &bindings)
        
        invoiceViewModel.$serviceSupplierNumber.sink { [weak self] serviceSupplierNumber in
            self?.serviceSupplierNumberLabel.text = serviceSupplierNumber
        }.store(in: &bindings)
        
        invoiceViewModel.$serviceSupplierAddress.sink { [weak self] serviceSupplierAddress in
            self?.serviceSupplierAddressLabel.text = serviceSupplierAddress
        }.store(in: &bindings)
        
        invoiceViewModel.$subTotal.sink { [weak self] subTotal in
            self?.subTotalLabel.text = subTotal
        }.store(in: &bindings)
        
        invoiceViewModel.$tax.sink { [weak self] tax in
            self?.taxLabel.text = tax
        }.store(in: &bindings)
        
        invoiceViewModel.$total.sink { [weak self] total in
            self?.totalLabel.text = total
        }.store(in: &bindings)
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func nextButtonDidPressed(_ sender: UIButton) {
        let successVc = SuccessViewController.instantiate(fromAppStoryboard: .AddOrder)
        successVc.modalPresentationStyle = .fullScreen
        self.present(successVc, animated: true)
    }
}


extension InvoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceViewModel.getServicesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceCell.identifier, for: indexPath) as? InvoiceCell else { return UITableViewCell() }
        cell.configureCell(data: invoiceViewModel.getService(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = InvoiceHeaderView()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        36
    }
}
