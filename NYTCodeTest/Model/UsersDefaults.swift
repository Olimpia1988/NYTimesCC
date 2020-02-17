import Foundation

class Keys {
   static let languagePreference = "perferedLanguge"
   static let userDefaults = UserDefaults.standard
 
  static func languagePersistenceSave(currentLanguge: LanguageSelector) {
    userDefaults.set(currentLanguge.rawValue, forKey: languagePreference)
 }

  
  static func languagePersistenceGet() -> LanguageSelector? {
    if let selectedLanguage = userDefaults.object(forKey: languagePreference) as? String {

      return LanguageSelector(rawValue: selectedLanguage)
      
    }
    return nil
  }
  
  

}
