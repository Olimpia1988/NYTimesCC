import Foundation

public enum MartianWord: String {
  case upperCase = "Boinga"
  case lowerCase = "boinga"
}

public enum LanguageSelector: String {
  case english = "English"
  case martian = "Martian"
  
  func swapLanguages() -> LanguageSelector {
    switch(self) {
    case .english:
      return .martian
    case .martian:
      return .english
    }
  }
}

struct Article: Codable {
  var title: String
  var images: [ArticleImages]?
  var body: String
  
  static func getArticles(from jsonData: Data) -> [Article] {
    do {
      let articles = try JSONDecoder().decode([Article].self, from: jsonData)
      return articles
    } catch {
      dump(error)
      return []
    }
  }
  
  static func getTextForLanguage(_ text: String, selectedLanguage: LanguageSelector) -> String {
    switch selectedLanguage {
    case .english: return text
    case .martian:
      let paragrapheSparator = text.components(separatedBy: "\n")
      var martianWords = [String]()
      
      for paragraph in paragrapheSparator {
        var word = paragraph.components(separatedBy: " ")
        
        for index in 0..<word.count {
          
          let currentWord = word[index]
          let endIndex = currentWord.endIndex
          guard let lastChar = currentWord.last else { break }
          
          if lastChar.isPunctuation {
            let endOfRange = currentWord.index(endIndex, offsetBy: -1)
            let rangeOfWords = currentWord.startIndex ..< endOfRange
            let cleanWord = String(currentWord[rangeOfWords])
            
            if cleanWord.count > 3 {
              if cleanWord.first!.isUppercase {
                word[index] = MartianWord.upperCase.rawValue + String(lastChar)
              } else {
                word[index] = MartianWord.lowerCase.rawValue + String(lastChar)
              }
            }
            
          } else if currentWord.count > 3  {
            if currentWord.first!.isUppercase {
              word[index] = MartianWord.upperCase.rawValue
            } else {
              word[index] = MartianWord.lowerCase.rawValue
            }
          }
        }
        martianWords.append(word.joined(separator: " "))
      }
      return martianWords.joined(separator: "\n")
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

