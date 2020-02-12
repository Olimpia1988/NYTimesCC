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
  
  static func getTextForLanguage(_ text: String,
                                 selectedLanguage: LanguageSelector) -> String {
    switch selectedLanguage {
    case .English: return text
    case .Martian:
      
    var wordSeparator = text.components(separatedBy: .whitespaces)
      
    var tempArray = [String]()
    for index in 0..<wordSeparator.count  {
      
      var paragraphSeparator = wordSeparator[index].components(separatedBy: "\n")
        
        if wordSeparator[index].count > 3 {
                  if wordSeparator[index].first!.isUppercase {
                  wordSeparator[index] = MartianWords.UpperCase.rawValue
                    tempArray.append(wordSeparator[index])
                } else {
                  wordSeparator[index] = MartianWords.LowerCase.rawValue
                    tempArray.append(wordSeparator[index])
                }
        
      } else {
        tempArray.append(wordSeparator[index])
      }
        
        
      
      }
      return tempArray.joined(separator: " ")
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

