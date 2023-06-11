

import UIKit


class LanguageHelper{
    

    private static var currentLanguage = UserDefaults.standard.string(forKey: "language")  != nil ? UserDefaults.standard.string(forKey: "language") : getlocal()
    
    static func setCurrentLanguage(langugaeCode: String) {
        currentLanguage = langugaeCode
        let defaults = UserDefaults.standard
        defaults.setValue(langugaeCode, forKey: "language")
        defaults.synchronize()
    }
    static func getlocal() -> String{
        let prefferedLanguage = Locale.preferredLanguages[0] as String        
        let arr = prefferedLanguage.components(separatedBy: "-")
        let deviceLanguage = arr.first
        return deviceLanguage! //en tr  de
    }
    static func getCurrentLanguage() -> String {
        return currentLanguage!
    }
    
    static var isArabic: Bool{
        getCurrentLanguage() == "ar"
    }
    
    static func getStrings(forKey key: String) -> String{
        switch currentLanguage {
        case "en":
            return "EnglishStrings.EnglishStringsDictionary[key] ?? key"
        case "ar":
            return "ArabicStrings.ArabicStringsDictionary[key] ?? key"
        default:
            return "ArabicStrings.ArabicStringsDictionary[key] ?? key"
        }
    }
}




