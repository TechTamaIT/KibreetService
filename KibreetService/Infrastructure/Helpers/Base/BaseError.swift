//
//  BaseError.swift
//  SFC
//
//  Created by Ahmed Elmansy on 11/10/2022.
//

import Foundation
import UIKit

struct BaseError{
    let message: String
    let style: ErrorStyle
}

enum ErrorStyle{
    /// Using actions with default value will add close button with no action
    case alert(actions: [UIAlertAction] = [.close])
    
    case popup(actions: [PopupAction] = [.close],icon: PopupIcon)
    
    enum PopupIcon{
        case warning
        case update
        case notifications
    }
    
    struct PopupAction{
        let title: String
        let action: (()->())?
        let theme: Theme
        
        init(title: String, action: (()->())? = nil, theme: Theme = .fill) {
            self.title = title
            self.action = action
            self.theme = theme
        }
    }
}

extension ErrorStyle.PopupAction{
    
    enum Theme{
        case fill, border
    }
    
    static var close: ErrorStyle.PopupAction{
        .init(title: LanguageHelper.getStrings(forKey: "LocalizationKeys.Close"), action: nil)
    }
    
    static func close(theme: Theme = .fill,completion: (()->())? = nil ) -> ErrorStyle.PopupAction {
        .init(title: LanguageHelper.getStrings(forKey: "LocalizationKeys.Close"), action: {
            completion?()
        }, theme: theme)
    }
    
}

extension UIAlertAction{
    
    static var close: UIAlertAction {
        .init(title: LanguageHelper.getStrings(forKey: "LocalizationKeys.Close"), style: .cancel)
    }
    
    static func close(completion: @escaping ()->()) -> UIAlertAction {
        .init(title: LanguageHelper.getStrings(forKey: "LocalizationKeys.Close"), style: .cancel) { _ in
            completion()
        }
    }
    
    static func action(title: String,completion: @escaping ()->()) -> UIAlertAction {
        .init(title: title, style: .default) { _ in
            completion()
        }
    }
    
}
