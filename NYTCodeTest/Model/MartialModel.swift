import Foundation

public enum LanguageSelector{
  case English
  case Martian
}

struct MartianTranslation {
  
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
