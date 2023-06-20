//
//  ServiceCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    static let identifier = "ServiceCell"
    var service: Service?
    var editTapped: ((Service) -> Void)?
    var deleteTapped: ((Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: Service) {
        serviceNameLabel.text = data.serviceTypeName
        service = data
    }
    
    @IBAction func deleteServiceDidPressed(_ sender: UIButton) {
        if let service = service {
            deleteTapped?(service.id)
        }
    }
    @IBAction func editServiceDidPressed(_ sender: UIButton) {
        if let service = service {
            editTapped?(service)
        }
    }
}
