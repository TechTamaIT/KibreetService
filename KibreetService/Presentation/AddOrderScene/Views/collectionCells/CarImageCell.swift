//
//  CarImageCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 11/06/2023.
//

import UIKit

class CarImageCell: UICollectionViewCell {
    
    static let idetifier = "CarImageCell"

    @IBOutlet weak var carImageBackgroundView: UIView!
    @IBOutlet weak var carImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image: UIImage) {
        carImage.image = image
        carImage.layer.cornerRadius = 6
        carImageBackgroundView.layer.cornerRadius = 6
    }
    
    func configureCellWithURl(imageURL: String) {
        carImage.loadImageFromUrl(imgUrl: imageURL)
        carImage.layer.cornerRadius = 6
        carImageBackgroundView.layer.cornerRadius = 6
    }
}
