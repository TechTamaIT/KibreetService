//
//  BaseViewController.swift
//  SFC
//
//  Created by Ahmed Labeeb on 05/07/2022.
//

import UIKit
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self == self.navigationController?.viewControllers.first {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    func navigateTo(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addBackground() {
            // screen width and height:
            let width = UIScreen.main.bounds.size.width
            let height = UIScreen.main.bounds.size.height

            let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height))
            imageViewBackground.image = UIImage(named: "EventBackground")

            // you can change the content mode:
            imageViewBackground.contentMode = UIView.ContentMode.scaleToFill

            self.view.addSubview(imageViewBackground)
            self.view.sendSubviewToBack(imageViewBackground)
    }
    
    func addBackButton() {
        let button = UIBarButtonItem.init(image: UIImage(named: "Icon feather-arrow-left"), style: UIBarButtonItem.Style.done, target: self, action: #selector(backClicked(_:)))
        self.navigationItem.leftBarButtonItem = button
    }
    
    @IBAction func backClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func homeClicked(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
}


class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackGroundImage()
    }
    
    func BackGroundImage() {
        let image = UIImageView.init(image: UIImage(named: "logo-backGround"))
        image.frame = self.view.frame
        self.view.addSubview(image)
        view.sendSubviewToBack(image)
    }
    
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
