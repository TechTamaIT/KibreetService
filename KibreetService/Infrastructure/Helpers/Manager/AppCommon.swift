//
//  AppCommon.swift
//  AshakAlena
//
//  Created by Mohammad Farhan on 22/12/176/8/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import UIKit

class AppCommon: UIViewController {
    
    static let sharedInstance = AppCommon()
    
    
    

    func isValidEmail(txtString:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: txtString)
    }
    
    func resetRootIntro(isComeFromInside: Bool = false) {
        if isComeFromInside {
            guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController else {return}
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "SelectLanguageVC") as? SelectLanguageVC else {return}
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}

