import Foundation

public enum LanguageSelector: String {
  case English = "English"
  case Martian = "Martian"
  
  func swapLanguages() -> LanguageSelector {
    switch(self) {
    case .English: return .Martian
    case .Martian: return .English
    }
  }
}

//public enum MartianWords: String {
//  case UpperCase = "Boinga"
//  case LowerCase = "boinga"
//}

struct MartianTranslation {
 
//  static func getTextForLanguage(_ text: String, selectedLanguage: LanguageSelector) -> String {
//
//    var separator = text.components(separatedBy: " ")
//    for word in 0..<separator.count {
//      if separator[word].count > 3 {
//        if separator[word].first!.isUppercase {
//          separator[word] = MartianWords.UpperCase.rawValue
//        } else {
//          separator[word] = MartianWords.LowerCase.rawValue
//        }
//      }
//    }
//    
//    return separator.joined(separator: " ")
//  }

  static func translateTitleToMartian(_ article: Articles,_ preferedLanguage: LanguageSelector) -> String {
    //TODO: refactor to an enum
    let upperCaseMartianWord = "Boinga"
    let lowerCaseMartianWord = "boinga"
    var separator = article.title.components(separatedBy: " ")
    for i in 0..<separator.count {
      if separator[i].count > 3 {
        if separator[i].first!.isUppercase {
          separator[i] = upperCaseMartianWord
        } else {
          separator[i] = lowerCaseMartianWord
        }
      }
    }
    return separator.joined(separator: " ")
  }
  

  static func translateBodyToMartian(_ article: Articles, _ preferedLanguage: LanguageSelector) -> String {
    //TODO: refactor to an enum
    let upperCaseMartianWord = "Boinga"
    let lowerCaseMartianWord = "boinga"
    var separator = article.body.components(separatedBy: " ")
    for i in 0..<separator.count {
      if separator[i].count > 3 {
        if separator[i].first!.isUppercase {
          separator[i] = upperCaseMartianWord
        } else {
          separator[i] = lowerCaseMartianWord
        }
      }
    }
    return separator.joined(separator: " ")
  }
}
