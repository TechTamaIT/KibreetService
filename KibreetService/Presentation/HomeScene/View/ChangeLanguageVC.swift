//
//  ChangeLanguageVC.swift
//  kabreet
//
//  Created by Essam Orabi on 14/03/2023.
//

import UIKit

class ChangeLanguageVC: UIViewController {

    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var arabicImage: UIImageView!
    @IBOutlet weak var englishImage: UIImageView!
    @IBOutlet weak var arabicLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        changeSelection()
    }
    
    func setupUI() {
        englishButton.setTitle("", for: .normal)
        arabicButton.setTitle("", for: .normal)
        backButton.setTitle("", for: .normal)
    }
    
    
    func changeSelection() {
        if LanguageManager.isArabic() {
            arabicLabel.textColor = UIColor(named: "mainColor")
            arabicImage.image = UIImage(named: "filledButton")
            englishLabel.textColor = UIColor(named: "languagesecondColor")
            englishImage.image = UIImage(named: "emptyButton")
        } else {
            englishLabel.textColor = UIColor(named: "mainColor")
            englishImage.image = UIImage(named: "filledButton")
            arabicLabel.textColor = UIColor(named: "languagesecondColor")
            arabicImage.image = UIImage(named: "emptyButton")
        }
    }
    
    @IBAction func arabicButtonDidPressed(_ sender: UIButton) {
        if !LanguageManager.isArabic() {
            LanguageManager.switchToArabic(isComeFromInside: true)
        }
    }
    
    @IBAction func englisshButtonDidPressed(_ sender: UIButton) {
        if LanguageManager.isArabic() {
            LanguageManager.switchToEnglish(isComeFromInside: true)
        }
    }
    
    @IBAction func backButtonButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
