//
//  CarInfoView.swift
//  kabreet
//
//  Created by Essam Orabi on 08/03/2023.
//

import UIKit

class CarInfoView: UIView {
    
    @IBOutlet weak var carCodeLabel: UILabel!
    public init() {
        super.init(frame: CGRect.zero)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nibName: "CarInfoView") else {return}
        xibSetup(contentView: view)
    }
    
    func configureView(code: String) {
        carCodeLabel.text = code
    }
    
}
