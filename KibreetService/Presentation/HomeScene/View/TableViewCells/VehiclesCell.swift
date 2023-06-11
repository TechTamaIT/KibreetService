//
//  VehiclesCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 03/06/2023.
//

import UIKit

class VehiclesCell: UITableViewCell {
    
    static let identifier = "VehiclesCell"

    @IBOutlet weak var maintitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkMarkImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(imageName: String, data: CarFullInfoModel) {
        checkMarkImage.image = UIImage(named: imageName)
        maintitleLabel.text = data.vehiclePlateNumber
        descriptionLabel.text = data.vehicleOilType
    }
    
}
