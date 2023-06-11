//
//  InvoiceHeaderView.swift
//  KibreetService
//
//  Created by Essam Orabi on 06/06/2023.
//

import UIKit

class InvoiceHeaderView: UIView {
    
    public init() {
        super.init(frame: CGRect.zero)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nibName: "InvoiceHeaderView") else {return}
        xibSetup(contentView: view)
    }
}
