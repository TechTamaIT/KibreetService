//
//  loadingManager.swift
//  SFC
//
//  Created by Mostafa Muhammad on 21/07/2022.
//

import Foundation
import UIKit
import Lottie

class LoadingView: UIView{}


class LoadingManager{
    
    private var indicatorView: LoadingView!
    private var animationView: LottieAnimationView!

    
    func showLoadingDialog() {
        
        guard let window = UIApplication.shared.windows.first else { return }
        let width = window.frame.width
        let height = window.frame.height
        indicatorView = LoadingView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        animationView = .init(name: "redSpinner")
        animationView.frame = CGRect(x: width / 2 - 50, y: height / 2 - 60, width: 80, height: 80)
        animationView?.animationSpeed = 2.5
        animationView?.loopMode = .loop
        indicatorView.addSubview(animationView)
        animationView?.play()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(indicatorView)
    }
    
    
    func removeLoadingDialog() {
        guard let window = UIApplication.shared.windows.first else { return }
        window.subviews.forEach { (view) in
            if view is  LoadingView {
                view.removeFromSuperview()
            }
        }
    }
}
