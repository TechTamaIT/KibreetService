//
//  HistoryViewController.swift
//  KibreetService
//
//  Created by Essam Orabi on 03/06/2023.
//

import UIKit
import Combine

class HistoryViewController: UIViewController {

    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var vehiclesTableView: UITableView!
    private let carsInfoViewModel = CarsInfoViewModel()
    private var bindings = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataLabel.isHidden = true
        setupTableView()
        bindingViewModelToView()
        carsInfoViewModel.getCarsInfo(onGoing: false)

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        vehiclesTableView.delegate = self
        vehiclesTableView.dataSource = self
        vehiclesTableView.register(UINib(nibName: VehiclesCell.identifier, bundle: nil), forCellReuseIdentifier: VehiclesCell.identifier)
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
    }


    func updateUI() {
        vehiclesTableView.reloadData()
        if carsInfoViewModel.result.value.count <= 0 {
            noDataLabel.isHidden = false
        }
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsInfoViewModel.result.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehiclesCell.identifier, for: indexPath) as? VehiclesCell else { return UITableViewCell() }
        let car = carsInfoViewModel.result.value[indexPath.row]
        cell.configureCell(imageName: "greenCheck", data: car)
        return cell
    }
}

