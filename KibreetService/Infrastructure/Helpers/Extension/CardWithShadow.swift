//
//  CardWithShadow.swift
//  Glamera Business
//
//  Created by Apple on 2/12/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
    @IBInspectable var _borderWidth: Float = 0.0
    @IBInspectable var _bordercolor: UIColor? = UIColor.gray
    @IBInspectable var shadowOffsetWidth: Int = 2
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var _shadowColor: UIColor? = UIColor.gray
    @IBInspectable var _shadowOpacity: Float = 0.16
    
    override func layoutSubviews() {
        layer.cornerRadius = _cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: _cornerRadius)
        layer.masksToBounds = false
        layer.borderWidth = CGFloat(_borderWidth)
        layer.borderColor = _bordercolor?.cgColor
        layer.shadowColor = _shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = _shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}


extension UIView {
    
    @discardableResult
    public func loadViewFromNib(nibName: String, in bundle: Bundle? = nil) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: bundle ?? Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    public func xibSetup(contentView: UIView) {
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
