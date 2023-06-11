//
//  InvoiceCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit

class InvoiceCell: UITableViewCell {
    static let identifier = "InvoiceCell"

    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var pricePerUnitLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: ServiceSummary) {
        itemNameLabel.text = data.name
        quantityLabel.text = "\(data.amount)"
        pricePerUnitLabel.text = "\(data.price) SAR"
        totalLabel.text = "\(data.price * data.amount) SAR"
    }
    
}
