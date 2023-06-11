//
//  TextFieldExtension.swift
//  BARAA
//
//  Created by Ahmed Wahdan on 9/26/20.
//  Copyright © 2020 BARAA Team. All rights reserved.
//

import UIKit

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(_ textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        let c = self
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
}



extension UIButton {
    func underline(color: UIColor) {
        guard let text = self.titleLabel?.text else { return }
        let attributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.underlineStyle: 1,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
        NSAttributedString.Key.foregroundColor: color
        ]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(NSAttributedString(attributedString: attributedString), for: .normal)
    }
}
