//
//  UIViewControllerExtensions.swift
//  ESports
//
//  Created by Mostafa Muhammad on 17/04/2022.
//

import Foundation
import UIKit
import MapKit
import SystemConfiguration

extension UIViewController{
    

        
    // show localized alert
    @objc func localized(style: UIAlertController.Style, alertTitle: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void){
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: style)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (_) in
            buttonAction()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func showLocalizedAlertWithOkButton(style: UIAlertController.Style, alertTitle: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void){
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: style)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (_) in
            buttonAction()
        }
        alert.addAction(action)
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }


    // show localized alert
    @objc func showLocalizedAlert(style: UIAlertController.Style, title: String, message: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func showErrorMessage(title: String? = nil, message: String, buttonTitle: String? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle ?? "Close".localized(), style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func addtransparentBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background")

        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleToFill

        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)

    }

    
    func pushVC(storyboard: String, viewController: String, animated: Bool){
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: viewController) as UIViewController
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func add(asChildViewController viewController: UIViewController, to view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }


}
