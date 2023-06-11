//
//  ServiceCategoryView.swift
//  KibreetService
//
//  Created by Essam Orabi on 09/06/2023.
//

import UIKit

protocol ServiceCategoryProtocol {
    func expandCollapsHeader(index: Int)
}
class ServiceCategoryView: UIView {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var categoryBackgroundView: UIView!
    var sectionIndex: Int?
    var delegate: ServiceCategoryProtocol?
    
    public init() {
        super.init(frame: CGRect.zero)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nibName: "ServiceCategoryView") else {return}
        xibSetup(contentView: view)
    }
    
    func configureCategoryView(name: String, isExpanded: Bool) {
        categoryNameLabel.textColor = isExpanded ? UIColor.hexColor(string: "#C02C4A") : .black
        categoryBackgroundView.layer.borderWidth = 1
        categoryBackgroundView.layer.borderColor = isExpanded ? UIColor.hexColor(string: "#C02C4A").cgColor : UIColor.hexColor(string: "#9EA6B1").cgColor
        categoryBackgroundView.layer.cornerRadius = 6
        categoryNameLabel.text = name
        arrowImage.image = UIImage(named: isExpanded ? "upArrowRed" : "downArrow")
        
    }
    
    @IBAction func openCloseButtonDidPressed(_ sender: UIButton) {
        if let index = sectionIndex {
            delegate?.expandCollapsHeader(index: index)
        }
    }
}
