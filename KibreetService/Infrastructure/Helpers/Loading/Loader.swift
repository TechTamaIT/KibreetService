//
//  Loader.swift
//  SFC
//
//  Created by Amr Mostafa on 16/08/2022.
//

import Foundation
import UIKit
//import Lottie

class Loader {
    
    private var indicatorView: LoadingView!
    private var animationView: UIActivityIndicatorView!

    
    func show(inView view : UIView) {
//        if indicatorView != nil {
//            guard let window = UIApplication.shared.windows.last else { return }
            let width = view.frame.width
            let height = view.frame.height
            indicatorView = LoadingView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        animationView = UIActivityIndicatorView(style: .large)
            animationView.frame = CGRect(x: width / 2 - 60, y: height / 2 - 60, width: 120, height: 120)
        animationView.color = UIColor.white
//            animationView?.animationSpeed = 2.5
//            animationView?.loopMode = .loop
            indicatorView.addSubview(animationView)
        animationView.startAnimating()
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicatorView)
//        }
    }
    
    
    func hide() {
        if indicatorView != nil {
            indicatorView.removeFromSuperview()
        }
    }
}
