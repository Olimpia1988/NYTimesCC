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
      
      let paragrapheSparator = text.components(separatedBy: "\n")
      var cleanArray = [String]()
      for paragraph in paragrapheSparator {
        
        var word = paragraph.components(separatedBy: " ")
        
        for index in 0..<word.count {
          if word[index].count > 3 {
            if word[index].first!.isUppercase {
              word[index] = MartianWords.UpperCase.rawValue
              
            } else {
              word[index] = MartianWords.LowerCase.rawValue
              
            }
            
          }
          
        }
        
        let wordArray =  word.joined(separator: " ")
        cleanArray.append(wordArray)
      }
      return cleanArray.joined(separator: "\n")
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

