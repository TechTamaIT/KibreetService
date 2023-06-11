//
//  UITextFieldExtensions.swift
//  Gamers
//
//  Created by Mostafa Muhammad on 16/04/2022.
//

import UIKit
import Combine

extension UITextField{
    
    // set attributed text for text field
    func setAttributedPlaceholder(forString string: String, withColor color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: string, attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    // Add right and left padding
    func addPaddingBothSides(withValue value: CGFloat){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.height))
        self.leftView = view
        self.leftViewMode = .always
        self.rightView = view
        self.rightViewMode = .always
    }
    
    // Add bottom border
    func addBottomBorder(withColor color: UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    /// - Parameter color: placeholder text color.
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    ///   Add padding to the left of the textfield rect.
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
    }

    ///   Add padding to the right of the textfield rect.
    /// - Parameter padding: amount of padding to apply to the right of the textfield rect.
    func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }

    ///   Add padding to the left of the textfield rect.
    /// - Parameters:
    ///   - image: left image.
    ///   - padding: amount of padding between icon and the left of textfield.
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        leftView = iconView
        leftViewMode = .always
    }

    /// Add padding to the right of the textfield rect.
    ///
    /// -  Parameters:
    ///   - image: right image.
    ///   - padding: amount of padding between icon and the right of textfield.
    func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
    }
    
    ///     Add tool bars to the textfield input accessory view.
    /// -   Parameters:
    ///   - items: The items to present in the toolbar.
    ///   - height: The height of the toolbar.
    func addToolbar(items: [UIBarButtonItem]?, height: CGFloat = 44) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: height))
        toolBar.setItems(items, animated: false)
        inputAccessoryView = toolBar
        return toolBar
    }
    
    
    // localized place holder
    @IBInspectable var lPlaceholder: String {
        get {
            return self.lPlaceholder
        }
        set {
            placeholder = LanguageHelper.getStrings(forKey: newValue)
        }
    }
    @IBInspectable var padding: CGFloat {
        get {
            return self.padding
        }
        set {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.height))
            self.leftView = view
            self.leftViewMode = .always
            self.rightView = view
            self.rightViewMode = .always
        }
    }
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
    
    open override func awakeFromNib() {
            super.awakeFromNib()
        if LanguageHelper.getCurrentLanguage() == "ar" {
                if textAlignment == .natural {
                    self.textAlignment = .right
                }
            }
        }
}

@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}
