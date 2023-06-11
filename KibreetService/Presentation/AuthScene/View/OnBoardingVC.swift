//
//  OnBoardingVC.swift
//  kabreet
//
//  Created by Essam Orabi on 04/03/2023.
//

import UIKit
import JXPageControl

class OnBoardingVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pagerView: JXPageControlJump!
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
        setupUI()
    }
    
    func setupUI() {
        nextButton.layer.cornerRadius = 10
        if LanguageManager.isArabic() {
            pagerView.transform = CGAffineTransformMakeScale(-1, 1)
        }
    }
    
    func setupCollectionview() {
        onBoardingCollectionView.delegate = self
        onBoardingCollectionView.dataSource = self
        onBoardingCollectionView.register(UINib(nibName: OnboardingCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        UserInfoManager.shared.setIsOnboardingPassed(true)
        let loginVc = LoginVC.instantiate(fromAppStoryboard: .Auth)
        loginVc.modalPresentationStyle = .fullScreen
        self.present(loginVc, animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if nextButton.currentTitle == "Finish".localized() {
            UserInfoManager.shared.setIsOnboardingPassed(true)
            let loginVc = LoginVC.instantiate(fromAppStoryboard: .Auth)
            loginVc.modalPresentationStyle = .fullScreen
            self.present(loginVc, animated: true)
        } else {
            if currentIndex < 2 {
                currentIndex += 1
            }
            pagerView.currentPage = currentIndex
            nextButton.setTitle(currentIndex == 2 ? "Finish".localized() : "Next".localized(), for: .normal)
            let rect = self.onBoardingCollectionView.layoutAttributesForItem(at:IndexPath(row: currentIndex, section: 0))?.frame
            self.onBoardingCollectionView.scrollRectToVisible(rect!, animated: true)
        }
    }
}

extension OnBoardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 256, height: 416)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = onBoardingCollectionView.contentOffset
        visibleRect.size = onBoardingCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = onBoardingCollectionView.indexPathForItem(at: visiblePoint) else { return }
        currentIndex = indexPath.item
        pagerView.currentPage = currentIndex
        nextButton.setTitle(currentIndex == 2 ? "Finish".localized() : "Next".localized(), for: .normal)
    }
}
