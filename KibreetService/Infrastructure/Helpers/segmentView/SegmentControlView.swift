//
//  SegmentControlView.swift
//  SFC
//
//  Created by Ahmed Labeeb on 12/08/2022.
//

import UIKit

protocol AuctionDetailsSegmentedControlDelegate: AnyObject {
    func valueChanged(_ index: Int)
}
class AuctionDetailsSegmentedControl {
    
    weak var delegate: AuctionDetailsSegmentedControlDelegate?
    
    private var view: UIView!
    init(delegate: AuctionDetailsSegmentedControlDelegate,
         view: UIView) {
        self.delegate = delegate
        self.view = view
        self.initalize()
    }
    private enum Constants {
        static let segmentedControlHeight: CGFloat = 40
        static let underlineViewColor: UIColor = UIColor.hexColor(string: "AB834C")
        static let unSelectedColor: UIColor = UIColor.hexColor(string: "BEBEBE")
        static let underlineViewHeight: CGFloat = 2
    }

    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
//        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        let segmentedControl = UISegmentedControl()
//        segmentedControl.apportionsSegmentWidthsByContent = true;
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = .clear
        } else {
            // Fallback on earlier versions
        }
        segmentedControl.layer.shadowColor = UIColor.clear.cgColor
        segmentedControl.insertSegment(withTitle: "auctionDetails".localized(), at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "falcons".localized(), at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Constants.unSelectedColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Constants.underlineViewColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)], for: .selected)

        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = Constants.underlineViewColor
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()

    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        if LanguageHelper.getCurrentLanguage() == "en" {
            return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
        }else {
            return bottomUnderlineView.rightAnchor.constraint(equalTo: segmentedControl.rightAnchor)
        }
    }()

    func initalize() {

        self.view.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubview(segmentedControl)
        segmentedControlContainerView.addSubview(bottomUnderlineView)

//        if #available(iOS 11.0, *) {
            let safeLayoutGuide = self.view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                segmentedControlContainerView.topAnchor.constraint(equalTo: safeLayoutGuide.topAnchor),
                segmentedControlContainerView.leadingAnchor.constraint(equalTo: safeLayoutGuide.leadingAnchor),
                segmentedControlContainerView.widthAnchor.constraint(equalTo: safeLayoutGuide.widthAnchor),
                segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
                ])
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
            ])

        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
            ])
        if #available(iOS 13.0, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(self.segmentedControl.numberOfSegments-1)  {
                    let backgroundSegmentView = self.segmentedControl.subviews[i]
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if let delegate = self.delegate {
            self.changeSegmentedControlLinePosition()
            delegate.valueChanged(sender.selectedSegmentIndex)
        }
        
    }

    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        
        var leadingDistance: CGFloat = 0
        if LanguageHelper.getCurrentLanguage() == "en" {
            leadingDistance = segmentWidth * segmentIndex
        }else {
            leadingDistance = segmentWidth * -1 * segmentIndex
        }
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }

}

