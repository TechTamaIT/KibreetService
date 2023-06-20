//
//  ServicesHistoryCell.swift
//  KibreetService
//
//  Created by Essam Orabi on 18/06/2023.
//

import UIKit

class ServicesHistoryCell: UITableViewCell {
    
    static let identifier = "ServicesHistoryCell"
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var kilometerLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var images = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionview()
        // Initialization code
    }
    
    func setupCollectionview() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(UINib(nibName: CarImageCell.idetifier, bundle: nil), forCellWithReuseIdentifier: CarImageCell.idetifier)
    }
    
    func configureCell(data: Service) {
        images = data.images
        imagesCollectionView.reloadData()
        serviceNameLabel.text = data.serviceTypeName
        amountLabel.text = "\(data.amount)"
        kilometerLabel.text = "\(data.vehicleKilometers) Km"
        
    }
}


extension ServicesHistoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarImageCell.idetifier, for: indexPath) as? CarImageCell else {return UICollectionViewCell()}
        cell.configureCellWithURl(imageURL: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 90)
    }
}
