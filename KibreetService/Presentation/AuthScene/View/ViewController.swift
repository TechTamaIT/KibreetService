//
//  ViewController.swift
//  kabreet
//
//  Created by Essam Orabi on 21/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeViewController()
        // Do any additional setup after loading the view.
    }
    
    func routeViewController() {
        if UserInfoManager.shared.isLoggedIn {
            guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController else {return}
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            
            if UserInfoManager.shared.getIsOnboardingPassed() {
                guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
                UIApplication.shared.windows.first?.rootViewController = homeVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else if UserInfoManager.shared.getIsFirstTime() {
                
                guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingVC") as? OnBoardingVC else {return}
                UIApplication.shared.windows.first?.rootViewController = homeVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else  {
                guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "SelectLanguageVC") as? SelectLanguageVC else {return}
                UIApplication.shared.windows.first?.rootViewController = homeVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
    
