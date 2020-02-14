import Foundation

struct Keys {
   static let languagePreference = "perferedLanguge"
  
  static func languagePreference(currentLanguge: LanguageSelector){
    
    let userDefaults = UserDefaults.standard
    
    userDefaults.set(LanguageSelector.RawValue.self, forKey: languagePreference)
    
    
    
//    var userPreference = Bool()
//
//    if currentLanguge == .english {
//       userPreference = true
//    } else {
//      userPreference = false
//
//      if currentLanguge == .martian {
//      userPreference = true
//    } else {
//      userPreference = false
//    }
//
//  }
//    print(userPreference)
//    print(currentLanguge)
//    return userPreference
 }

}
