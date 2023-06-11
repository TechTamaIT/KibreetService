//
//  OnboardingCell.swift
//  kabreet
//
//  Created by Essam Orabi on 04/03/2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"

    @IBOutlet weak var onboardingItemTitle: UILabel!
    @IBOutlet weak var onboardingItemDescription: UILabel!
    @IBOutlet weak var onboardingItemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
