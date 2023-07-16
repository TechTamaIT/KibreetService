//
//  AppDelegate.swift
//  KibreetService
//
//  Created by Essam Orabi on 29/05/2023.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        sessionExpiration()
        return true
    }
    
    func sessionExpiration() {
        NotificationCenter.default.addObserver(forName: .notAuthorized, object: nil, queue: OperationQueue.main) {[weak self] notification in
            if let vc = self?.getTopVC() {
                let alert = UIAlertController(title: "Warning", message: "you are not authoriized", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default) { _ in
                    UserInfoManager.shared.logout()
                    let loginVc = LoginVC.instantiate(fromAppStoryboard: .Auth)
                    self?.window?.rootViewController = loginVc
                }
                alert.addAction(action)
                vc.present(alert, animated: true)
            }
        }
    }
    
    
    func getTopVC() -> UIViewController? {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        return nil
    }
}

