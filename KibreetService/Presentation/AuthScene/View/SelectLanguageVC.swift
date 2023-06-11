//
//  SelectLanguageVC.swift
//  kabreet
//
//  Created by Essam Orabi on 04/03/2023.
//

import UIKit

class SelectLanguageVC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var arabicCardView: CardView!
    @IBOutlet weak var englishCardView: CardView!
    @IBOutlet weak var englishImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var letStartButton: UIButton!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var arabicImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeSelection()
        setupUI()
    }
    
    func setupUI() {
        letStartButton.layer.cornerRadius = 10
        arabicButton.setTitle("", for: .normal)
        englishButton.setTitle("", for: .normal)
        mainView.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }
    
    func changeSelection() {
        if LanguageManager.isArabic() {
            arabicCardView._bordercolor = UIColor(named: "mainColor")
            arabicCardView._borderWidth = 1
            arabicLabel.textColor = UIColor(named: "mainColor")
            arabicImage.image = UIImage(named: "filledButton")
            
            englishCardView._bordercolor = UIColor(named: "borderColor")
            arabicCardView._borderWidth = 1
            englishLabel.textColor = UIColor(named: "languagesecondColor")
            englishImage.image = UIImage(named: "emptyButton")
        } else {
            englishCardView._bordercolor = UIColor(named: "mainColor")
            arabicCardView._borderWidth = 1
            englishLabel.textColor = UIColor(named: "mainColor")
            englishImage.image = UIImage(named: "filledButton")
            
            arabicCardView._bordercolor = UIColor(named: "borderColor")
            arabicCardView._borderWidth = 1
            arabicLabel.textColor = UIColor(named: "languagesecondColor")
            arabicImage.image = UIImage(named: "emptyButton")
        }
    }
    
    @IBAction func arabicButtonPressed(_ sender: UIButton) {
        if !LanguageManager.isArabic() {
            LanguageManager.switchToArabic()
        }
    }
    
    @IBAction func englishButtonPressed(_ sender: UIButton) {
        if LanguageManager.isArabic() {
            LanguageManager.switchToEnglish()
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        UserInfoManager.shared.setIsFirstTime(true)
        let onBoardingVc = OnBoardingVC.instantiate(fromAppStoryboard: .Auth)
        onBoardingVc.modalPresentationStyle = .fullScreen
        self.present(onBoardingVc, animated: true)
    }
}
