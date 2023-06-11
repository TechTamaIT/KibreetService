//
//  DriverSettingsCell.swift
//  kabreet
//
//  Created by Essam Orabi on 08/03/2023.
//

import UIKit

class DriverSettingsCell: UITableViewCell {
    
    static let identifier = "DriverSettingsCell"

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsBackground: CardView!
    @IBOutlet weak var settingsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(data: DriverSettingsModel, isLastItem: Bool = false) {
        settingsLabel.text = data.settingName
        settingsImage.image = UIImage(named: data.SettingImage)
        settingsBackground.backgroundColor = isLastItem ? UIColor(named: "logout") : UIColor(named: "settingCellColor")
    }
}
