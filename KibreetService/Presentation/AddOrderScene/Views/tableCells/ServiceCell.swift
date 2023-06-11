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
    var editTapped: ((Int) -> Void)?
    var deleteTapped: ((Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: Service) {
        serviceNameLabel.text = "\(data.serviceType)"
    }
    
    @IBAction func deleteServiceDidPressed(_ sender: UIButton) {
        deleteTapped?(0)
    }
    @IBAction func editServiceDidPressed(_ sender: UIButton) {
        editTapped?(0)
    }
}
