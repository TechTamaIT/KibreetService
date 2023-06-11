//
//  SelectServiceCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit

class SelectServiceCell: UITableViewCell {
    
    static let identifier = "SelectServiceCell"

    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(service: String) {
        serviceNameLabel.text = service
    }
}
