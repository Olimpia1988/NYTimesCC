import Foundation

public enum MartianWords: String {
  case UpperCase = "Boinga"
  case LowerCase = "boinga"
}

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

struct Articles: Codable {
  var title: String
  var images: [ArticleImages]?
  var body: String
  
  
  static func getArticles(from jsonData: Data) -> [Articles] {
    do {
      let articles = try JSONDecoder().decode([Articles].self, from: jsonData)
      return articles
    } catch {
      dump(error)
      return []
      
    }
  }
  
  static func getTextForLanguage(_ text: String, selectedLanguage: LanguageSelector) -> String {
    switch selectedLanguage {
    case .English: return text
    case .Martian:
      var separator = text.components(separatedBy: " ")
      for word in 0..<separator.count {
        if separator[word].count > 3 {
          if separator[word].first!.isUppercase {
            separator[word] = MartianWords.UpperCase.rawValue
          } else {
            separator[word] = MartianWords.LowerCase.rawValue
          }
        }
      }
      return separator.joined(separator: " ")
    }
  }
}

struct ArticleImages: Codable {
  var topImage: Bool
  var url: String
  var width: Int
  var height: Int
  
  private enum CodingKeys : String, CodingKey {
    case topImage = "top_image"
    case url, width, height
  }
}

