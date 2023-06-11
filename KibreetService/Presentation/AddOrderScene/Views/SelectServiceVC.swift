//
//  SelectServiceVC.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit
import Combine

class SelectServiceVC: UIViewController {

    @IBOutlet weak var servicesTableView: UITableView!
    private let carsInfoViewModel = SelectServiceViewModel()
    private var bindings = Set<AnyCancellable>()
    
    var visiId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindingViewModelToView()
        carsInfoViewModel.getCategories(visiteId: visiId)

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.register(UINib(nibName: SelectServiceCell.identifier, bundle: nil), forCellReuseIdentifier: SelectServiceCell.identifier)
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
        servicesTableView.reloadData()
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}


extension SelectServiceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return carsInfoViewModel.result.value.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if carsInfoViewModel.expandedArray[section] {
            return carsInfoViewModel.result.value[section].centerServices.count
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectServiceCell.identifier, for: indexPath) as? SelectServiceCell else { return UITableViewCell() }
        let subCategory = carsInfoViewModel.result.value[indexPath.section].centerServices[indexPath.row]
        cell.configureCell(service: subCategory.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ServiceCategoryView()
        let subCategory = carsInfoViewModel.result.value[section]
        header.sectionIndex = section
        header.delegate = self
        header.configureCategoryView(name: subCategory.serviceCategory.serviceTypeName, isExpanded: carsInfoViewModel.expandedArray[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let service = carsInfoViewModel.result.value[indexPath.section].centerServices[indexPath.row]
        let submitServiceVC = UploadServiceViewController.instantiate(fromAppStoryboard: .AddOrder)
        submitServiceVC.visiteId = visiId
        submitServiceVC.availabilityId = service.id
        submitServiceVC.serviceName = service.name
        submitServiceVC.modalPresentationStyle = .fullScreen
        self.present(submitServiceVC, animated: true)
    }
}


extension SelectServiceVC: ServiceCategoryProtocol {
    func expandCollapsHeader(index: Int) {
        carsInfoViewModel.expandedArray[index] = !carsInfoViewModel.expandedArray[index] 
        servicesTableView.reloadData()
    }
}
