//
//  CarDetailsVC.swift
//  kabreet
//
//  Created by Essam Orabi on 06/03/2023.
//

import UIKit
import Combine

class CarDetailsVC: UIViewController {

    @IBOutlet weak var carInfoTableView: UITableView!
    private let carsInfoViewModel = CarsInfoViewModel()
    let refreshControl = UIRefreshControl()
    private var bindings = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindingViewModelToView()
        carsInfoViewModel.getCarsInfo()
    }
    
    func setupTableView() {
        carInfoTableView.delegate = self
        carInfoTableView.dataSource = self
        carInfoTableView.register(UINib(nibName: VehiclesCell.identifier, bundle: nil), forCellReuseIdentifier: VehiclesCell.identifier)
        carInfoTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
    }
    
    @objc func refreshTableView(_ sender: UIRefreshControl) {
        carsInfoViewModel.getCarsInfo()
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        let scanVc = ScanCarViewController.instantiate(fromAppStoryboard: .AddOrder)
        scanVc.modalPresentationStyle = .overFullScreen
        self.present(scanVc, animated: true)
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
