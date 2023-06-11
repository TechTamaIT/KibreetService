//
//  SelectImageCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import UIKit

class SelectImageCell: UICollectionViewCell {
    
    static let idetifier = "SelectImageCell"
    
    var openCameraTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func openCamera(_ sender: UIButton) {
        openCameraTapped?()
    }
}
